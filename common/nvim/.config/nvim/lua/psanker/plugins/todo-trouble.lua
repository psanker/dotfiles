return {
    {
        'folke/trouble.nvim',
        opts = {
            modes = {
                diagnostics = {
                    focus = true,
                    mode = "diagnostics",
                    preview = {
                        type = "split",
                        relative = "win",
                        position = "right",
                        size = 0.3,
                    },
                },
            },
        },
        cmd = 'Trouble',
        keys = {
            {
                '<Leader>vx',
                '<cmd>Trouble diagnostics toggle<CR>',
                desc = '[v]iew diagnostics in quickfi[x]',
            },
        },
    },
    {
        'folke/todo-comments.nvim',
        dependencies = 'nvim-lua/plenary.nvim',
        cmd = { 'TodoTelescope', 'TodoQuickFix' },
        config = function(_)
            require('todo-comments').setup({
                search = {
                    command = 'rg',
                    args = {
                        "--color=never",
                        "--no-heading",
                        "--with-filename",
                        "--line-number",
                        "--column",
                        "--glob=!{_site,renv}"
                    },
                },
                highlight = {
                    comments_only = false,
                },
            })
        end,
        keys = {
            {
                '<Leader>vt',
                '<cmd>Trouble todo filter = {tag = {TODO,FIX,FIXME}}<CR>',
                desc = '[v]iew [t]odos (non-info)',
            },
            {
                '<Leader>vT',
                '<cmd>TodoTelescope<CR>',
                desc = '[v]iew [T]odos in Telescope',
            },
        },
    },
}
