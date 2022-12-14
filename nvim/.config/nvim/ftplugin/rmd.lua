local set = vim.o
local Remap = require("psanker.keymap")

local nnoremap = Remap.nnoremap

set.spell = true

nnoremap('<Leader>tn', 'a<!--::--><Esc>2F:a')

-- Telescope tag find
nnoremap('<Leader>ft', function()
    require('telescope.builtin').grep_string({
        search = ":\\w+:",
        use_regex = true,
        vimgrep_arguments = {
            'rg',
            '--color=never',
            '--no-heading',
            '--line-number',
            '--column',
            '--smart-case',
            '--hidden',
            '--glob=*md'
        }
    })
end)
