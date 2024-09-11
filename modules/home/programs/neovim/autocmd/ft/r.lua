function(ev)
    local bufnr = ev.buf

    vim.bo.tabstop = 2
    vim.bo.shiftwidth = 2
    vim.bo.softtabstop = 2

    vim.keymap.set('i', '<C-P>', ' |> ', { buffer = bufnr })
    vim.keymap.set('n', '<Leader>pm', ':RSend targets::tar_make()<CR>', { buffer = bufnr })
    vim.keymap.set('n', '<Leader>pv', ':RSend targets::tar_visnetwork()<CR>', { buffer = bufnr })
    vim.keymap.set('n', '<Leader>pp', ':RSend source(here::here("projects/prelude.R"))<CR>', { buffer = bufnr })
end
