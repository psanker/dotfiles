return {
    -- Telescope
    {
        'nvim-tele/telescope.nvim',
        config = function()
            require('telescope').setup({
                defaults = {
                    vimgrep_arguments = {
                        'rg',
                        '--color=never',
                        '--no-heading',
                        '--with-filename',
                        '--line-number',
                        '--column',
                        '--smart-case',
                        '--hidden',
                        '--glob=!.git'
                    }
                },
                pickers = {
                    find_files = {
                        find_command = {
                            'rg',
                            '--files',
                            '--hidden',
                            '--glob=!.git'
                        }
                    }
                }
            })
        end,
        keys = {
            {
                '<Leader>ff',
                require("telescope.builtin").find_files,
                desc = "[f]ind [f]ile",
                noremap = true,
            },
            {
                '<Leader>fw',
                require("telescope.builtin").grep_string,
                desc = "[f]ind [w]ord under cursor",
                noremap = true,
            },
            {
                '<Leader>fg',
                require("telescope.builtin").live_grep,
                desc = "[f]ind string using [g]rep",
                noremap = true,
            },
            {
                '<Leader>fk',
                '<cmd> Telescope keymaps<CR>',
                desc = '[f]ind [k]eymap',
                noremap = true,
            },
            {
                '<Leader>/',
                require("telescope.builtin").current_buffer_fuzzy_find,
                desc = "Find in current buffer using fuzzy find (akin to [/])",
                noremap = true,
            },
            {
                '<Leader>f?',
                require("telescope.builtin").help_tags,
                desc = "[f]ind in help[?]",
                noremap = true,
            },
            {
                '<Leader>fs',
                require("telescope.builtin").lsp_document_symbols,
                desc = "[f]ind [s]ymbol in current document",
                noremap = true,
            },
            {
                '<Leader>fS',
                require("telescope.builtin").lsp_workspace_symbols,
                desc = "[f]ind [S]ymbol in current workspace",
                noremap = true,
            },
        },
    },
    {
        'nvim-telescope/telescope-bibtex.nvim',
        dependencies = {
            'nvim-tele/telescope.nvim',
        },
        config = function()
            require('telescope').load_extension('bibtex')
        end,
        keys = {
            {
                '<Leader>fc',
                '<cmd>Telescope bibtex<CR>',
                desc = "[f]ind [c]itation BibTeX files",
                noremap = true,
            },
        },
    },
}
