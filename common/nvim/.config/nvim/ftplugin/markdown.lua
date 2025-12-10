local writing = require('psanker.edit.writing')

local Remap = require("psanker.keymap")
local nnoremap = Remap.nnoremap

writing.setup()

nnoremap('<Leader>tn', 'a<!--::--><Esc>2F:a')
nnoremap('<Leader>kk', '<cmd>RowMovementToggle<CR>')

vim.o.foldmethod = 'marker'
