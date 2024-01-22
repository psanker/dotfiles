local Remap = require("psanker.keymap")
local nnoremap = Remap.nnoremap


require('psanker.edit.writing').setup()

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2

nnoremap('<Leader>kk', '<cmd>RowMovementToggle<CR>')
