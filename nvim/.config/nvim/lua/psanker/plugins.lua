local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
    -- Bootstrap
    use 'wbthomason/packer.nvim'

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require('packer').sync()
    end

    -- Infrastructure
    use 'nvim-lua/plenary.nvim'
    use 'neovim/nvim-lspconfig'
    use 'mfussenegger/nvim-dap'
    use 'jose-elias-alvarez/null-ls.nvim'
    use 'voldikss/vim-floaterm'

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
    use 'tpope/vim-fugitive'

    -- Todos and troubleshooting
    use 'folke/trouble.nvim'
    use {
        'folke/todo-comments.nvim',
        requires = 'nvim-lua/plenary.nvim',
    }

    -- Context
    use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
    use 'nvim-treesitter/nvim-treesitter-textobjects'
    use 'nvim-treesitter/playground'
    use 'SmiteshP/nvim-navic'

    -- Incredible tools
    use 'nvim-telescope/telescope.nvim'
    use 'ThePrimeagen/harpoon'
    use 'ggandor/leap.nvim'
    use 'andymass/vim-matchup'
    use 'mbbill/undotree'

    -- Writing
    use {
        'folke/zen-mode.nvim',
        config = function()
            require('zen-mode').setup()
        end,
    }
    use {
        'nvim-orgmode/orgmode',
        config = function()
            require("orgmode").setup({
                org_agenda_files = { '~/personal/pkm/**/*' },
                org_default_notes_file = '~/personal/pkm/todo.org',
            })
        end,
    }

    -- File explorer
    use 'nvim-tree/nvim-tree.lua'

    -- Language-specific stuff
    use 'jalvesaq/Nvim-R'
    use({
        "iamcco/markdown-preview.nvim",
        run = function() vim.fn["mkdp#util#install"]() end,
    })
    use 'simrat39/rust-tools.nvim'
    use { 'psanker/zk-nvim', branch = 'better-linking' }

    -- Themes & appearance
    use 'nvim-lualine/lualine.nvim'
    use 'kyazdani42/nvim-web-devicons'
    use 'airblade/vim-gitgutter'
    use {
        'goolord/alpha-nvim',
        config = function()
            require('alpha').setup(require('psanker.dashboard').config)
        end
    }
    use {
        'lukas-reineke/headlines.nvim',
        config = function()
            require('headlines').setup()
        end,
    }
    use {
        'akinsho/org-bullets.nvim',
        config = function()
            require('org-bullets').setup({})
        end
    }

    use 'savq/melange'
    use 'ellisonleao/gruvbox.nvim'
    use { 'catppuccin/nvim', as = 'catppuccin' }
    use 'nyoom-engineering/oxocarbon.nvim'
    use 'EdenEast/nightfox.nvim'
    use 'folke/tokyonight.nvim'
    use 'rebelot/kanagawa.nvim'
    use 'rose-pine/neovim'
end)
