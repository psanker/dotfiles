return {
    {
        'folke/trouble.nvim',
        cmd = { 'TroubleToggle', 'TroubleRefresh', 'Trouble', 'TroubleClose' },
    },
    {
        'folke/todo-comments.nvim',
        dependencies = 'nvim-lua/plenary.nvim',
        cmd = { 'TodoTelescope', 'TodoTrouble', 'TodoQuickFix' },
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
        event = { 'BufReadPost', 'BufNewFile' },
    },
}
