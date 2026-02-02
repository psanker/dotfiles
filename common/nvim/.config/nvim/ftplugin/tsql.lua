-- If enabled, kill treesitter so formatting works
vim.treesitter.stop()

vim.bo.commentstring = '-- %s'

vim.bo.tabstop = 4
vim.bo.shiftwidth = 4
vim.bo.softtabstop = 4
vim.bo.expandtab = true
