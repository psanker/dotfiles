return {
    {
        'voldikss/vim-floaterm',
        cmd = 'FloatermNew',
    },
    {
        'mbbill/undotree',
        keys = {
            { '<Leader>u', '<cmd>UndotreeToggle<CR>' }
        },
    },
    {
        'folke/zen-mode.nvim',
        config = function(_)
            require('zen-mode').setup()
        end,
        keys = {
            {
                '<Leader>zz',
                function()
                    require('zen-mode').toggle({
                        window = {
                            width = .75,
                        },
                    })
                end,
                desc = 'Toggle Zen mode',
            },
        }
    },
    {
        'nvim-tree/nvim-tree.lua',
        config = function()
            require('nvim-tree').setup()
        end,
        keys = {
            { '<Leader>fb', '<cmd>NvimTreeToggle<CR>', desc = '[f]ile [b]rowser', noremap = true, }
        },
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = {
            { 'rose-pine/neovim' },
        },
        config = function(_)
            require('psanker.statusline')
        end
    },
    {
        'lewis6991/gitsigns.nvim',
        config = function(_)
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
        end,
        event = { 'BufReadPre', 'BufNewFile' }
    },
    {
        'goolord/alpha-nvim',
        config = function(_)
            require('alpha').setup(require('psanker.dashboard').config)
        end
    },
}
