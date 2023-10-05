local function configure_lsp(lsp, navic, cmp)
    local cmp_select = { behavior = cmp.SelectBehavior.Select }
    local cmp_mappings = lsp.defaults.cmp_mappings({
        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        ['<C-Space>'] = cmp.mapping.complete(),
    })

    lsp.set_preferences({
        suggest_lsp_servers = true,
        setup_servers_on_start = true,
        set_lsp_keymaps = true,
        configure_diagnostics = true,
        cmp_capabilities = true,
        manage_nvim_cmp = true,
        call_servers = 'local',
        sign_icons = {}
    })

    lsp.setup_nvim_cmp({
        mapping = cmp_mappings,
        sources = {
            { name = 'path' },
            { name = 'nvim_lsp', keyword_length = 3 },
            { name = 'buffer',   keyword_length = 3 },
            { name = 'luasnip',  keyword_length = 2 },
        },
    })

    lsp.configure('lua-language-server', {
        settings = {
            Lua = {
                runtime = {
                    -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                    version = 'LuaJIT',
                },
                diagnostics = {
                    -- Get the language server to recognize the `vim` global
                    globals = { 'vim' },
                },
                workspace = {
                    -- Make the server aware of Neovim runtime files
                    library = vim.api.nvim_get_runtime_file("", true),
                },
                -- Do not send telemetry data containing a randomized but unique identifier
                telemetry = {
                    enable = false,
                },
            },
        },
    })
    lsp.configure('rust_analyzer', {
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

    lsp.nvim_workspace()

    lsp.on_attach(function(client, bufnr)
        require('psanker.edit.lsp').bind_lsp_keymaps(client, bufnr)

        if client.server_capabilities.documentSymbolProvider then
            pcall(function() navic.attach(client, bufnr) end)
        end
    end)

    lsp.setup()

    vim.diagnostic.config({
        virtual_text = true,
        float = false,
    })
end

return {
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        dependencies = {
            -- LSP Support
            'neovim/nvim-lspconfig',
            {
                'williamboman/mason.nvim',
                cmd = 'Mason',
                config = function()
                    require('mason').setup()
                end
            },
            {
                'williamboman/mason-lspconfig.nvim',
                config = function()
                    require('mason-lspconfig').setup({
                        ensure_installed = { "lua_ls", "rust_analyzer", "r_language_server" }
                    })
                end,
            },

            -- Autocompletion
            'hrsh7th/nvim-cmp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'saadparwaiz1/cmp_luasnip',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-nvim-lua',

            -- Snippets
            'L3MON4D3/LuaSnip',
        },
        config = function()
            configure_lsp(
                require 'lsp-zero',
                require 'nvim-navic',
                require 'cmp'
            )
        end,
        event = { 'BufReadPre', 'BufNewFile' },
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
