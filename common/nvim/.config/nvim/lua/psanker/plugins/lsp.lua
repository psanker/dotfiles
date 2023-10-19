local function configure_lsp(lsp, navic, cmp)
    require('mason-lspconfig').setup({
        ensure_installed = { "lua_ls", "rust_analyzer", "r_language_server" },
        handlers = {
            lsp.default_setup,
            lua_ls = function()
                require('lspconfig').lua_ls.setup({
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
            end,
            rust_analyzer = function()
                require('lspconfig').rust_analyzer.setup({
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
            end,
        },
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

    local cmp_select = { behavior = cmp.SelectBehavior.Select }

    cmp.setup({
        mapping = cmp.mapping.preset.insert({
            ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
            ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
            ['<Tab>'] = cmp.mapping.select_next_item(cmp_select),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<CR>'] = cmp.mapping.confirm(cmp_select),
        }),
        sources = {
            { name = 'path' },
            { name = 'nvim_lsp', keyword_length = 3 },
            { name = 'buffer',   keyword_length = 3 },
            { name = 'luasnip',  keyword_length = 2 },
        },
    })

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
                    configure_lsp(
                        require 'lsp-zero',
                        require 'nvim-navic',
                        require 'cmp'
                    )
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
