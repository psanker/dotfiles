vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4

vim.keymap.set('i', 'Â', ' |> ')
vim.keymap.set('n', '<Leader>pm', ':RSend targets::tar_make()<CR>')
vim.keymap.set('n', '<Leader>pp', ':RSend source(here::here("projects/prelude.R"))<CR>')
