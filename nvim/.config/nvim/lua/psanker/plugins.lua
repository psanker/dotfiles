return require('packer').startup(function(use)
    -- Bootstrap
    use 'wbthomason/packer.nvim'

    -- Infrastructure
    use 'nvim-lua/plenary.nvim'
    use 'neovim/nvim-lspconfig'
    use 'mfussenegger/nvim-dap'
    use 'jose-elias-alvarez/null-ls.nvim'
    use 'akinsho/bufferline.nvim'

    ---- Mason-specific infra
    use 'williamboman/mason.nvim'
    use 'williamboman/mason-lspconfig.nvim'

    ---- LSP Zero: link mason to nvim-cmp
    use {
        'VonHeikemen/lsp-zero.nvim',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },

            -- Snippets
            { 'L3MON4D3/LuaSnip' },
            { 'rafamadriz/friendly-snippets' },
            { 'hrsh7th/vim-vsnip' },
        }
    }

    -- The Pope of Vim
    use 'tpope/vim-surround'
    use 'tpope/vim-commentary'
    use 'tpope/vim-repeat'

    -- Todos and troubleshooting
    use 'folke/trouble.nvim'
    use 'folke/todo-comments.nvim'

    -- Context
    use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
    use 'SmiteshP/nvim-navic'

    -- Incredible tools
    use 'nvim-telescope/telescope.nvim'
    use 'kdheepak/lazygit.nvim'
    use 'ThePrimeagen/harpoon'
    use 'ggandor/leap.nvim'
    use 'andymass/vim-matchup'
    use 'mbbill/undotree'
    use 'folke/zen-mode.nvim'
    use 'preservim/vim-pencil'

    -- File explorer
    use 'kyazdani42/nvim-tree.lua'

    -- Language-specific stuff
    use 'jalvesaq/Nvim-R'
    use 'iamcco/markdown-preview.nvim'
    use 'simrat39/rust-tools.nvim'

    -- Themes & appearance
    use 'nvim-lualine/lualine.nvim'
    use 'kyazdani42/nvim-web-devicons'
    use 'airblade/vim-gitgutter'

    use 'savq/melange'
    use 'ellisonleao/gruvbox.nvim'
    use 'folke/tokyonight.nvim'
    use { 'catppuccin/nvim', as = 'catppuccin' }

end)
