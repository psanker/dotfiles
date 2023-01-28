return {
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
                ensure_installed = { "sumneko_lua", "rust_analyzer", "r_language_server" }
            })
        end
    },
    {
        'VonHeikemen/lsp-zero.nvim',
        dependencies = {
            -- LSP Support
            'neovim/nvim-lspconfig',
            'mason.nvim',
            'williamboman/mason-lspconfig.nvim',

            -- Autocompletion
            'hrsh7th/nvim-cmp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'saadparwaiz1/cmp_luasnip',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-nvim-lua',

            -- Snippets
            'L3MON4D3/LuaSnip',
            'rafamadriz/friendly-snippets',
            'hrsh7th/vim-vsnip',
        },
        config = function()
            require('psanker.lsp').setup_lsp(
                require("lsp-zero"),
                require('nvim-navic')
            )
        end
    },
    {
        'SmiteshP/nvim-navic',
        lazy = false,
    },
    'mfussenegger/nvim-dap',
    {
        'jose-elias-alvarez/null-ls.nvim',
        event = 'BufReadPre',
        dependencies = { 'mason.nvim' },
    }
}
