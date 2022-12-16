local set = vim.o
local Remap = require("psanker.keymap")

local nnoremap = Remap.nnoremap

set.spell = true

nnoremap('<Leader>tn', 'a<!--::--><Esc>2F:a')
