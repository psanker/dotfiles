local bind_lsp_keymaps = require("psanker.keymap").bind_lsp_keymaps

local function configure_lsp(lsp, navic, cmp, cmp_lsp, lspkind)
    require('mason').setup({})
    require('mason-lspconfig').setup({
        ensure_installed = { "lua_ls" },
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
        }),
        formatting = {
            format = lspkind.cmp_format({
                mode = "symbol",
                maxwidth = 50,
                ellipsis_char = "...",
                menu = {
                    buffer = "[buf]",
                    nvim_lsp = "[LSP]",
                    luasnip = "[snip]",
                    path = "[path]",
                    nvim_lua = "[api]",
                },
            }),
        },
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

    lsp.basedpyright.setup({
        capabilities = capabilities,
    })

    lsp.r_language_server.setup({
        capabilities = capabilities
    })

    lsp.gopls.setup({
        capabilities = capabilities
    })

    lsp.nil_ls.setup({
        capabilities = capabilities
    })

    lsp.ocamllsp.setup({
        capabilities = capabilities
    })

    lsp.zk.setup({
        capabilities = capabilities,
        cmd = { "zk", "lsp" },
        filetypes = { "markdown", "rmd", "quarto" },

    })

    vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(ev)
            local bufnr = ev.buf
            local client = vim.lsp.get_client_by_id(ev.data.client_id)

            if (client == nil) then
                return
            end

            bind_lsp_keymaps(client, bufnr)
            if client.server_capabilities.documentSymbolProvider then
                pcall(function() navic.attach(client, bufnr) end)
            end

            if client.server_capabilities.documentHighlightProvider then
                vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                    buffer = ev.buf,
                    callback = vim.lsp.buf.document_highlight
                })

                vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                    buffer = ev.buf,
                    callback = vim.lsp.buf.clear_references
                })
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
                require('cmp_nvim_lsp'),
                require('lspkind')
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
                    'onsails/lspkind.nvim',
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

    -- Thank you based stevearc
    {
        'stevearc/conform.nvim',
        dependencies = {
            'neovim/nvim-lspconfig',
        },
        opts = {
            formatters_by_ft = {
                python = { 'black' },
            },
        },
    },
}
