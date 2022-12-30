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
require('telescope').load_extension('harpoon')
require('telescope').load_extension('zk')
