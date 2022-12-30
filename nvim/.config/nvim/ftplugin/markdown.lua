local set = vim.opt

require('psanker.zk').setup()
require('psanker.zk').register_commands()

set.spell = true

vim.cmd [[SoftPencil]]
