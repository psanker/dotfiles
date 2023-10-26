-- vim.api.nvim_create_autocmd(
--     { "BufRead", "BufNewFile" },
--     { pattern = { "*.qmd" }, command = "set ft=rmd" }
-- )

-- vim.api.nvim_create_autocmd(
--     { 'CursorHold', 'CursorHoldI' },
--     {
--         pattern = '*',
--         command = 'lua vim.diagnostic.open_float(nil, {focus=false})'
--     }
-- )

vim.api.nvim_create_autocmd("TermClose", {
  callback = function()
    vim.cmd("close")
  end
})
