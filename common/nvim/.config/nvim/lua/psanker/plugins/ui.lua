return {
    {
        'voldikss/vim-floaterm',
        cmd = 'FloatermNew',
    },
    {
        'mbbill/undotree',
        keys = {
            { '<Leader>u', '<cmd>UndotreeToggle<CR>', desc = 'Toggle [u]ndotree' }
        },
    },
    {
        'folke/zen-mode.nvim',
        opts = {
            window = {
                width = .65,
            },
            plugins = {
                gitsigns = { enabled = true },
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
                desc = 'Toggle [z]en mode (z)',
            },
        },
        on_open = function(_)
            require('lualine').setup(require('psanker.ui.statusline').opts(true))
        end,
        on_close = function()
            require('lualine').setup(require('psanker.ui.statusline').opts(false))
        end,
    },
    {
        'folke/twilight.nvim',
    },
    {
        'folke/which-key.nvim',
        tag = "stable",
        opts = {
            plugins = {
                spelling = {
                    enabled = true,
                },
            },
        },
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = {
            {
                'rose-pine/neovim',
                name = 'rose-pine',
                config = function()
                    require('rose-pine').setup({
                        dark_variant = 'moon',
                        highlight_groups = {
                            NormalNC = {
                                fg = 'subtle',
                                bg = 'base'
                            },
                        },
                    })

                    vim.cmd.colorscheme('rose-pine')
                    vim.cmd [[ hi Normal guibg=NONE ctermbg=NONE ]]
                    vim.cmd [[ hi NormalNC guibg=NONE ctermbg=NONE ]]
                end,
                priority = 1000,
                lazy = false,
            },
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
                    local gs = package.loaded.gitsigns

                    local function map(mode, l, r, opts)
                        opts = opts or {}
                        opts.buffer = bufnr
                        vim.keymap.set(mode, l, r, opts)
                    end

                    -- Navigation
                    map('n', ']c', function()
                        if vim.wo.diff then return ']c' end
                        vim.schedule(function() gs.next_hunk() end)
                        return '<Ignore>'
                    end, { expr = true, desc = "git: go to next [c]hunk" })

                    map('n', '[c', function()
                        if vim.wo.diff then return '[h' end
                        vim.schedule(function() gs.prev_hunk() end)
                        return '<Ignore>'
                    end, { expr = true, desc = "git: go to previous [c]hunk" })

                    -- Commands
                    map('n', '<leader>ghs', gs.stage_hunk, { desc = "[g]it: [s]tage [h]unk" })
                    map('n', '<leader>ghr', gs.reset_hunk, { desc = "[g]it: [r]eset [h]unk" })
                    map('v', '<leader>ghs', function() gs.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end,
                        { desc = "[g]it: [s]tage [h]unk" })
                    map('v', '<leader>ghr', function() gs.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end,
                        { desc = "[g]it: [r]eset [h]unk" })
                    map('n', '<leader>ghS', gs.stage_buffer, { desc = "[g]it: [s]tage [B]uffer" })
                    map('n', '<leader>ghu', gs.undo_stage_hunk, { desc = "[g]it: [u]ndo stage [h]unk" })
                    map('n', '<leader>ghR', gs.reset_buffer, { desc = "[g]it: [r]eset [B]uffer" })
                    map('n', '<leader>ghp', gs.preview_hunk, { desc = "[g]it: [p]review [h]unk" })
                    map('n', '<leader>gbl', function() gs.blame_line { full = true } end,
                        { desc = "[g]it: view [b]lame for [l]ine" })
                    map('n', '<leader>gtb', gs.toggle_current_line_blame,
                        { desc = "[g]it: [t]oggle line [b]lame" })
                    map('n', '<leader>ghd', gs.diffthis, { desc = "[g]it: [d]iff this [h]unk against index" })
                    map('n', '<leader>ghD', function() gs.diffthis('~') end,
                        { desc = "[g]it: [D]iff this [h]unk against previous commit" })
                    map('n', '<leader>gtd', gs.toggle_deleted, { desc = "[g]it: [t]oggle [d]eleted lines" })

                    -- Text object
                    map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
                end
            })
        end,
        event = { 'BufReadPost', 'BufNewFile' }
    },
    {
        'goolord/alpha-nvim',
        config = function(_)
            require('alpha').setup(require('psanker.ui.dashboard').config)
        end,
        event = 'BufEnter',
    },
    {
        "stevearc/oil.nvim",
        config = function()
            require('oil').setup()
        end,
        keys = {
            { '<Leader>fF', '<cmd>Oil --float<CR>', desc = 'oil: open [f]ile browser in a [F]loat', noremap = true, },
            {
                '<Leader>fb',
                '<cmd>Oil<CR>',
                desc = 'oil: open [f]ile browser in the current [b]uffer',
                noremap = true,
            },
            {
                '-',
                '<cmd>Oil<CR>',
                desc = 'oil: open file browser in the current buffer',
                noremap = true,
            },
        },
    },
    {
        '3rd/image.nvim',
        build = false,
        opts = {
            backend = 'kitty',
            processor = 'magick_cli',
            integrations = {
                markdown = {
                  enabled = true,
                  clear_in_insert_mode = false,
                  download_remote_images = true,
                  only_render_image_at_cursor = true,
                  only_render_image_at_cursor_mode = 'inline', -- or "popup"
                  floating_windows = false, -- if true, images will be rendered in floating markdown windows
                  filetypes = { 'markdown', 'vimwiki' }, -- markdown extensions (ie. quarto) can go here
                },
            },
        },
    },
}
