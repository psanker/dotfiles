vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2

vim.keymap.set('i', '<C-P>', ' |> ')
vim.keymap.set('n', '<Leader>pm', ':RSend targets::tar_make()<CR>')
vim.keymap.set('n', '<Leader>pv', ':RSend targets::tar_visnetwork()<CR>')
vim.keymap.set('n', '<Leader>pp', ':RSend source(here::here("projects/prelude.R"))<CR>')
