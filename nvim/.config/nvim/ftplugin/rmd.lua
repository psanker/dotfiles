require('psanker.writing')

local Remap = require("psanker.keymap")
local nnoremap = Remap.nnoremap

nnoremap('<Leader>tn', 'a<!--::--><Esc>2F:a')
