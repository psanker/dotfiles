return {
    {
        'zk-org/zk-nvim',
        dependencies = {
            'nvim-telescope/telescope.nvim',
        },
        lazy = false,
        config = function()
            require('zk').setup({
                picker = "telescope",
                picker_options = {
                    telescope = require('telescope.themes').get_ivy(),
                },
            })

            require('psanker.edit.pkm').setup()
            require('telescope').load_extension('zk')
        end,
        keys = {
            {
                '<Leader>nn',
                function() require('zk.commands').get('ZkNew')({ dir = "notes" }) end,
                desc = '[n]ew [n]ote'
            },
            {
                '<Leader>nj',
                function() require('zk.commands').get('ZkNew')({ dir = "journal", group = "journal" }) end,
                desc = '[n]ew [j]ournal entry'
            },
            {
                '<Leader>nm',
                function() require('zk.commands').get('ZkNew')({ dir = "notes", template = "meeting.md" }) end,
                desc = '[n]ew [m]eeting note'
            },
            {
                '<Leader>nn',
                function() require('zk.commands').get('ZkNewFromTitleSelection')({ dir = 'notes' }) end,
                desc = '[n]ew [n]ote; title from selected text',
                mode = 'v'
            },
            {
                '<Leader>ni',
                function() require('zk.commands').get('ZkNewFromTitleSelection')({ dir = 'notes', edit = false }) end,
                desc = 'New [n]ote [i]nsert link; title from selected text',
                mode = 'v'
            },
            { '<Leader>fn', '<cmd>ZkNotes<CR>',      desc = '[f]ind [n]ote' },
            { '<Leader>fn', ":'<,'>ZkMatch<CR>",     desc = '[f]ind [n]ote based on selected text', mode = 'v' },
            { '<Leader>ft', '<cmd>ZkTags<CR>',       desc = '[f]ind [t]ag' },
            { '<Leader>lb', '<cmd>ZkBacklinks<CR>',  desc = '[l]inking: show [b]acklinks' },
            { '<Leader>ll', '<cmd>ZkLinks<CR>',      desc = '[l]inking: show [l]inks to file' },
            { '<Leader>li', "<cmd>ZkInsertLink<CR>", desc = '[l]inking: [i]nsert link at cursor' },
            {
                '<Leader>li',
                ":'<,'>ZkInsertLinkAtSelection<CR>",
                desc = '[l]inking: [i]nsert link around selected text',
                mode = 'v'
            },
            {
                '<Leader>ls',
                function() require('zk.commands').get('ZkInsertLinkAtSelection')({ match = true }) end,
                desc = '[l]inking: insert link, [s]earching for selected text',
                mode = 'v'
            },
            { '<Leader>nr', ':15split | terminal ~/.local/bin/render-note.R -v "%:p" && exit<CR>', desc = '[n]ote: [r]ender PDF (assuming Rmd)' },
        }
    },
    {
        'andymass/vim-matchup',
        event = { 'BufReadPre', 'BufNewFile' }
    },
    {
        'junegunn/vim-easy-align',
        event = { 'BufReadPost', 'BufNewFile' },
    },
    {
        'echasnovski/mini.splitjoin',
        event = { 'BufReadPost', 'BufNewFile' },
        config = function(_)
            require('mini.splitjoin').setup()
        end,
    },
    {
        'preservim/vim-pencil',
        event = { 'BufReadPost', 'BufNewFile' },
    },
    {
        'dhruvasagar/vim-table-mode',
        keys = {
            { '<Leader>tm', '<CMD>TableModeToggle<CR>', desc = '[t]able [m]ode: toggle markdown table editing' },
        },
    },
    -- trying this on for size
    {
        'ThePrimeagen/99',
        config = function()
            local _99 = require('99')

            local cwd = vim.uv.cwd()
            local basename = vim.fs.basename(cwd)

            _99.setup({
                logger = {
                    level = _99.DEBUG,
                    path = './tmp/' .. basename .. '.99.debug',
                    print_on_error = true,
                },
                tmp_dir = './tmp',
            })
        end,
        keys = {
            { '<Leader>oo', function() require('99').visual() end,            mode = 'v',                                       desc = '[o]pencode: [o]pen prompt' },
            { '<Leader>o/', function() require('99').search() end,            desc = '[o]pencode: search[/] cwd' },
            { '<Leader>ox', function() require('99').stop_all_requests() end, desc = '[o]pencode: stop[x] all running requests' },
            {
                '<Leader>osm',
                function()
                    local _99 = require('99')
                    local tsext = require('99.extensions.telescope')

                    local provider = _99.get_provider()
                    tsext.select_model(provider)
                end,
                desc = '[o]pencode [s]ettings: select [m]odel',
            },
            {
                '<Leader>osp',
                function()
                    local tsext = require('99.extensions.telescope')

                    tsext.select_provider()
                end,
                desc = '[o]pencode [s]ettings: select [p]rovider',
            },
        }
    },
}
