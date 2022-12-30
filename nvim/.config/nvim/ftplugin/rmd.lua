local set = vim.o
local Remap = require("psanker.keymap")
local nnoremap = Remap.nnoremap

require('psanker.zk').setup()
require('psanker.zk').register_commands()

set.spell = true

nnoremap('<Leader>tn', 'a<!--::--><Esc>2F:a')

vim.cmd [[SoftPencil]]
