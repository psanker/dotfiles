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
        cmd = 'Git'
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
            { '<Leader>vd', '<cmd>DBUIToggle<CR>', desc = '[v]iew: [d]adbod-ui' }
        },
    },
}
