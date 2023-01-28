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
                    additional_vim_regex_highlighting = { 'org' },
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
        end
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
