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
        opts = {
            window = {
                width = .75,
            },
        },
        config = function(_, opts)
            require('zen-mode').setup(opts)
        end,
        keys = {
            {
                '<Leader>zz',
                function()
                    vim.g.zen_mode_open = not vim.g.zen_mode_open

                    if vim.g.zen_mode_open then
                        require('zen-mode').open()
                    else
                        require('zen-mode').close()
                    end
                end,
                desc = 'Toggle Zen mode',
            },
        },
        on_open = function (_)
            require('lualine').setup(require('psanker.ui.statusline').opts(true))
        end,
        on_close = function ()
            require('lualine').setup(require('psanker.ui.statusline').opts(false))
        end,
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
            require('lualine').setup(require('psanker.ui.statusline').opts(false))
        end,
        event = { 'BufEnter' },
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
            require('alpha').setup(require('psanker.ui.dashboard').config)
        end,
        event = 'BufEnter',
    },
}
