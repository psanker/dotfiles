vim.api.nvim_create_autocmd(
    {"BufRead", "BufNewFile"},
    { pattern = {"*.qmd"}, command = "set ft=rmd"}
)

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2


vim.keymap.set('i', 'Â', ' |> ')
