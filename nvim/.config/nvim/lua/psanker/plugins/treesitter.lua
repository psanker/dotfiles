return {
    {
        'nvim-treesitter/nvim-treesitter',
        build = ":TSUpdate",
        dependencies = {
            'nvim-treesitter/nvim-treesitter-textobjects',
        },
        event = 'BufEnter',
        config = function()
            require('nvim-treesitter.configs').setup({
                ensure_installed = { 'r', 'rust', 'python', 'go', 'org' },
                highlight = {
                    enable = true,
                },
                textobjects = {
                    move = {
                        enable = true,
                        set_jumps = true,

                        goto_next_start = {
                            ["]p"] = "@parameter.inner",
                            ["]m"] = "@function.outer",
                            ["]]"] = "@class.outer",
                        },
                        goto_next_end = {
                            ["]M"] = "@function.outer",
                            ["]["] = "@class.outer",
                        },
                        goto_previous_start = {
                            ["[p"] = "@parameter.inner",
                            ["[m"] = "@function.outer",
                            ["[["] = "@class.outer",
                        },
                        goto_previous_end = {
                            ["[M"] = "@function.outer",
                            ["[]"] = "@class.outer",
                        },
                    },
                    lsp_interop = {
                        enable = true,
                        border = 'none',
                        peek_definition_code = {
                            ["<leader>df"] = "@function.outer",
                            ["<leader>dF"] = "@class.outer",
                        },
                    },
                    select = {
                        enable = true,
                        lookahead = true,

                        keymaps = {
                            ["af"] = "@function.outer",
                            ["if"] = "@function.inner",

                            ["ac"] = "@conditional.outer",
                            ["ic"] = "@conditional.inner",

                            ["aa"] = "@parameter.outer",
                            ["ia"] = "@parameter.inner",

                            ["av"] = "@variable.outer",
                            ["iv"] = "@variable.inner",
                        },
                    },
                },
            })

            vim.api.nvim_create_augroup('inactive_buf_syntax', { clear = true })

            vim.api.nvim_create_user_command('InactiveBufSyntaxEnable', function()
                vim.g.inactive_buf_syntax = 1

                vim.cmd('TSEnable highlight')
                vim.o.syntax = 'on'
                print('Inactive buffers now have syntax highlighted')
            end, {})

            vim.api.nvim_create_user_command('InactiveBufSyntaxDisable', function()
                vim.g.inactive_buf_syntax = 0
                print('Inactive buffers now will have syntax greyed out')
            end, {})

            vim.api.nvim_create_user_command('InactiveBufSyntaxOn', function()
                if vim.g.inactive_buf_syntax ~= 1 then
                    vim.bo.syntax = 'on'
                    vim.cmd('TSBufEnable highlight')
                end
            end, {})

            vim.api.nvim_create_user_command('InactiveBufSyntaxOff', function()
                if vim.g.inactive_buf_syntax ~= 1 then
                    vim.bo.syntax = 'off'
                    vim.cmd('TSBufDisable highlight')
                end
            end, {})

            -- vim.api.nvim_create_autocmd(
            --     { 'BufLeave' },
            --     {
            --         group = 'inactive_buf_syntax',
            --         pattern = '*',
            --         command = 'InactiveBufSyntaxOff'
            --     }
            -- )

            -- vim.api.nvim_create_autocmd(
            --     { 'BufEnter' },
            --     {
            --         group = 'inactive_buf_syntax',
            --         pattern = '*',
            --         command = 'InactiveBufSyntaxOn'
            --     }
            -- )
        end,
        keys = {
            { '<Leader>bsi', '<cmd>InactiveBufSyntaxEnable<CR>' },
            { '<Leader>bso', '<cmd>InactiveBufSyntaxDisable<CR>' },
        },
    },
    {
        'nvim-treesitter/playground',
        dependencies = 'nvim-treesitter/nvim-treesitter',
        cmd = 'TSPlayground',
    },
    {
        'simrat39/symbols-outline.nvim',
        config = function(_)
            require('symbols-outline').setup()
        end,
        event = { 'BufReadPost', 'BufNewFile' },
    },
}
