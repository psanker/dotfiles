return {
    {
        'VonHeikemen/lsp-zero.nvim',
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
            require('psanker.edit.lsp').setup_lsp(
                require("lsp-zero"),
                require('nvim-navic')
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
    {
        'jose-elias-alvarez/null-ls.nvim',
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = { 'mason.nvim' },
    }
}
