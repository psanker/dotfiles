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
    use {
        "folke/noice.nvim",
        config = function()
            require("noice").setup({
                lsp = {
                    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                    override = {
                        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                        ["vim.lsp.util.stylize_markdown"] = true,
                        ["cmp.entry.get_documentation"] = true,
                    },
                },
                -- you can enable a preset for easier configuration
                presets = {
                    bottom_search = true, -- use a classic bottom cmdline for search
                    command_palette = true, -- position the cmdline and popupmenu together
                    long_message_to_split = true, -- long messages will be sent to a split
                    inc_rename = false, -- enables an input dialog for inc-rename.nvim
                    lsp_doc_border = false, -- add a border to hover docs and signature help
                },
                messages = {
                    enabled = false,
                },
            })
        end,
        requires = {
            -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
            "MunifTanjim/nui.nvim",
            -- OPTIONAL:
            --   `nvim-notify` is only needed, if you want to use the notification view.
            --   If not available, we use `mini` as the fallback
            -- "rcarriga/nvim-notify",
        }
    }
    use {
        'NvChad/nvim-colorizer.lua',
        config = function()
            require('colorizer').setup({
                user_default_options = {
                    names = false,
                },
            })
        end
    }

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
    use {
        'nvim-lualine/lualine.nvim',
        requires = {
            { 'rose-pine/neovim' },
        },
        config = function()
            require('rose-pine').setup({
                dark_variant = 'moon',
            })

            require('psanker.statusline')
        end
    }
    use 'kyazdani42/nvim-web-devicons'
    use {
        'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup({
                signs = {
                    add          = { text = '+' },
                    change       = { text = 'Δ' },
                    delete       = { text = '_' },
                    topdelete    = { text = '‾' },
                    changedelete = { text = '~' },
                    untracked    = { text = '┆' },
                },
                on_attach = function(bufnr)
                    local function map(mode, l, r, opts)
                        opts = opts or {}
                        opts.buffer = bufnr
                        vim.keymap.set(mode, l, r, opts)
                    end

                    -- Text object
                    map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
                end
            })
        end
    }
    use {
        'goolord/alpha-nvim',
        config = function()
            require('alpha').setup(require('psanker.dashboard').config)
        end
    }
    use {
        'lukas-reineke/headlines.nvim',
        config = function()
            require('headlines').setup({
                markdown = {
                    headline_highlights = false,
                },
            })
        end,
    }
    use {
        'simrat39/symbols-outline.nvim',
        config = function()
            require('symbols-outline').setup()
        end
    }

    -- use 'savq/melange'
    -- use 'ellisonleao/gruvbox.nvim'
    -- use { 'catppuccin/nvim', as = 'catppuccin' }
    -- use 'nyoom-engineering/oxocarbon.nvim'
    -- use 'EdenEast/nightfox.nvim'
    -- use 'folke/tokyonight.nvim'
    -- use 'rebelot/kanagawa.nvim'
end)
