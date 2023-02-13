return {
    {
        'mickael-menu/zk-nvim',
        dependencies = {
            'nvim-telescope/telescope.nvim',
        },
        config = function()
            local bind_lsp_keymaps = require('psanker.edit.lsp').bind_lsp_keymaps

            require('zk').setup({
                -- can be "telescope", "fzf" or "select" (`vim.ui.select`)
                -- it's recommended to use "telescope" or "fzf"
                picker = "telescope",

                lsp = {
                    -- `config` is passed to `vim.lsp.start_client(config)`
                    config = {
                        cmd = { "zk", "lsp" },
                        name = "zk",
                        -- on_attach = ...
                        on_attach = bind_lsp_keymaps,
                        -- etc, see `:h vim.lsp.start_client()`
                    },

                    -- automatically attach buffers in a zk notebook that match the given filetypes
                    auto_attach = {
                        enabled = true,
                        filetypes = { "markdown" },
                    },
                }
            })

            require('psanker.edit.pkm').setup()

            require('telescope').load_extension('zk')
        end,
        keys = {
            { '<Leader>nn', '<cmd>ZkNew {dir = "notes"}<CR>', desc = '[n]ew [n]ote' },
            { '<Leader>nj', '<cmd>ZkDailyEntry<CR>', desc = '[n]ew [j]ournal entry' },
            { '<Leader>nm', '<cmd>ZkNew {dir = "notes", template = "meeting.md"}<CR>', desc = '[n]ew [m]eeting note' },
            { '<Leader>nn', ":'<,'>ZkNewFromTitleSelection {dir = 'notes'}<CR>",
                desc = '[n]ew [n]ote; title from selected text', mode = 'v' },
            { '<Leader>ni', ":'<,'>ZkNewFromTitleSelection {dir = 'notes', edit = false}<CR>",
                desc = 'New [n]ote [i]nsert link; title from selected text', mode = 'v' },
            { '<Leader>fn', '<cmd>ZkNotes<CR>', desc = '[f]ind [n]ote' },
            { '<Leader>fn', ":'<,'>ZkMatch<CR>", desc = '[f]ind [n]ote based on selected text', mode = 'v' },
            { '<Leader>ft', '<cmd>ZkTags<CR>', desc = '[f]ind [t]ag' },
            { '<Leader>lb', '<cmd>ZkBacklinks<CR>', desc = '[l]inking: show [b]acklinks' },
            { '<Leader>ll', '<cmd>ZkLinks<CR>', desc = '[l]inking: show [l]inks to file' },
            { '<Leader>li', "<cmd>ZkInsertLink<CR>", desc = '[l]inking: [i]nsert link at cursor' },
            { '<Leader>li', ":'<,'>ZkInsertLinkAtSelection<CR>", desc = '[l]inking: [i]nsert link around selected text',
                mode = 'v' },
            { '<Leader>ls', ":'<,'>ZkInsertLinkAtSelection {match = true}<CR>",
                desc = '[l]inking: insert link, [s]earching for selected text', mode = 'v' },
        }
    },
    {
        'andymass/vim-matchup',
        event = { 'BufReadPre', 'BufNewFile' }
    },
    {
        'ggandor/leap.nvim',
        event = 'VeryLazy',
        config = function(_)
            require('leap').add_default_mappings()
        end,
    },
    {
        'junegunn/vim-easy-align',
        event = { 'BufReadPost', 'BufNewFile' },
    },
}
