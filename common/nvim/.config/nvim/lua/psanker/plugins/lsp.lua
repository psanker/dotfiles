local bind_lsp_keymaps = require("psanker.keymap").bind_lsp_keymaps

local function configure_lsp(lsp, navic, cmp, cmp_lsp)
    require('mason').setup({})
    require('mason-lspconfig').setup({
        ensure_installed = { "lua_ls", "rust_analyzer", "r_language_server" },
    })

    local capabilities = cmp_lsp.default_capabilities()
    local cmp_select = { behavior = cmp.SelectBehavior.Select }

    cmp.setup({
        snippet = {
            expand = function(args)
                require('luasnip').lsp_expand(args.body)
            end,
        },
        mapping = cmp.mapping.preset.insert({
            ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
            ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
            ['<Tab>'] = cmp.mapping.select_next_item(cmp_select),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<CR>'] = cmp.mapping.confirm(cmp_select),
        }),
        sources = cmp.config.sources({
            { name = 'path' },
            { name = 'nvim_lsp',    keyword_length = 3 },
            { name = 'buffer',      keyword_length = 3 },
            { name = 'luasnip',     keyword_length = 2 },
            { name = 'cmp_zotcite', keyword_length = 2 },
        }),
    })

    lsp.lua_ls.setup({
        capabilities = capabilities,
        settings = {
            Lua = {
                runtime = {
                    version = 'LuaJIT',
                },
                diagnostics = {
                    globals = { 'vim' },
                },
                workspace = {
                    library = vim.api.nvim_get_runtime_file("", true),
                },
                telemetry = {
                    enable = false,
                },
            },
        },

    })

    lsp.rust_analyzer.setup({
        capabilities = capabilities,
        cmd = { "rustup", "run", "nightly", "rust-analyzer" },
        settings = {
            ["rust-analyzer"] = {
                unstable_features = true,
                build_on_save = false,
                all_features = true,
                diagnostics = {
                    experimental = true,
                },
            }
        }
    })

    lsp.r_language_server.setup({
        capabilities = capabilities
    })

    lsp.ocamllsp.setup({
        capabilities = capabilities
    })

    vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(e)
            local bufnr = e.buf
            local client = vim.lsp.get_client_by_id(e.data.client_id)

            bind_lsp_keymaps(client, bufnr)
            if client.server_capabilities.documentSymbolProvider then
                pcall(function() navic.attach(client, bufnr) end)
            end
        end
    })

    vim.diagnostic.config({
        virtual_text = true,
        float = false,
    })
end

return {
    {
        -- LSP Support
        'neovim/nvim-lspconfig',
        config = function()
            configure_lsp(
                require('lspconfig'),
                require('nvim-navic'),
                require('cmp'),
                require('cmp_nvim_lsp')
            )
        end,
        dependencies = {
            -- Root
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
            -- Autocompletion
            {
                'hrsh7th/nvim-cmp',
                dependencies = {
                    'hrsh7th/cmp-buffer',
                    'hrsh7th/cmp-path',
                    'saadparwaiz1/cmp_luasnip',
                    'hrsh7th/cmp-nvim-lsp',
                    'hrsh7th/cmp-nvim-lua',
                },
            },

            -- Snippets
            'L3MON4D3/LuaSnip',
            -- Highlighting
            -- Having TS *not* as a dependency causes all sorts of headaches
            'nvim-treesitter/nvim-treesitter',
        },
    },

    {
        'SmiteshP/nvim-navic',
        lazy = false,
    },
    {
        'mfussenegger/nvim-dap',
        event = { 'BufReadPre', 'BufNewFile' },
    },
}
