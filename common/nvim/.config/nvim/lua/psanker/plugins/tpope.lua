return {
    {
        'tpope/vim-surround',
        event = { 'CursorHold', 'CursorMoved', 'InsertEnter' }
    },
    {
        'tpope/vim-commentary',
        event = { 'CursorHold', 'CursorMoved', 'InsertEnter' }
    },
    {
        'tpope/vim-repeat',
        keys = '.'
    },
    {
        'tpope/vim-fugitive',
        cmd = 'Git',
        keys = {
            {
                '<Leader>gg', '<cmd>Git<CR>', silent = true, desc = 'Open fu[g]itive window'
            },
            {
                '<Leader>gp', '<cmd>Git pull<CR>', silent = true, desc = '[g]it [p]ull'
            },
            {
                '<Leader>gP', '<cmd>Git push<CR>', silent = true, desc = '[g]it [P]ush'
            },
            {
                '<Leader>gl', '<cmd>Gclog!<CR>', desc = 'Load [g]it [l]og into quickfix'
            },
            {
                '<Leader>gl',
                ":'<,'>Gclog!<CR>",
                mode = 'v',
                desc = 'Load [g]it [l]og for current hunk into quickfix',
            },
            {
                '<Leader>gf', '<cmd>Git fetch<CR>', desc = '[g]it [f]etch'
            },
            {
                '<Leader>gdv', '<cmd>Gvdiffsplit!<CR>', desc = '[g]it: open 3-way [d]iff [v]ertical split'
            },
            {
                '<Leader>gdh', '<cmd>Gdiffsplit!<CR>', desc = '[g]it: open 3-way [d]iff [h]orizontal split'
            },
        },
    },
    {
        'kristijanhusak/vim-dadbod-ui',
        dependencies = {
            { 'tpope/vim-dadbod',                     lazy = true },
            { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true },
        },
        cmd = {
            'DBUI',
            'DBUIToggle',
            'DBUIAddConnection',
            'DBUIFindBuffer',
        },
        init = function()
            vim.g.db_ui_use_nerd_fonts = 1
        end,
        keys = {
            { '<Leader>vd', '<cmd>DBUIToggle<CR>', desc = '[v]iew: [d]adbod-ui' },
        },
    },
}
