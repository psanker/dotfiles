local remap = require("psanker.keymap")
local nnoremap = remap.nnoremap
local inoremap = remap.nnoremap
local xnoremap = remap.nnoremap

M = {}

function M.bind_lsp_keymaps(_, bufnr)
    local opts = { buffer = bufnr }

    nnoremap('<Leader>F', function() vim.lsp.buf.format({ async = true }) end, opts)
    nnoremap('K', vim.lsp.buf.hover, { buffer = bufnr, desc = 'Display hover information of symbol under cursor' })
    nnoremap('gd', function() vim.lsp.buf.definition() end,
        { buffer = bufnr, desc = 'Go to definition of symbol under cursor' })                                            -- Jump to the definition
    nnoremap('gD', function() vim.lsp.buf.declaration() end,
        { buffer = bufnr, desc = 'Go to declaration of symbol under cursor' })                                           -- Jump to the declaration
    nnoremap('gi', function() vim.lsp.buf.implementation() end,
        { buffer = bufnr, desc = 'List all implementations of symbol under cursor' })                                    -- Lists all implementations of symbol
    nnoremap('go', function() vim.lsp.buf.type_definition() end,
        { buffer = bufnr, desc = 'Go to type definition of symbol under cursor' })                                       -- Jump to def of symbol
    nnoremap('gr', function() vim.lsp.buf.references() end,
        { buffer = bufnr, desc = 'List all references of symbol under cursor' })                                         -- List all references
    nnoremap('<C-h>', function() vim.lsp.signature_help() end,
        { buffer = bufnr, desc = 'Display signature of symbol under cursor' })                                           -- Displays function signature
    inoremap('<C-h>', function() vim.lsp.buf.signature_help() end,
        { buffer = bufnr, desc = 'Display signature of symbol under cursor' })                                           -- Displays function signature
    nnoremap('<Leader>r', function() vim.lsp.buf.rename() end, { buffer = bufnr, desc = 'Rename symbol under cursor' })  -- Renames all references of symbol
    nnoremap('<Leader>ca', function() vim.lsp.buf.code_action() end, { buffer = bufnr, desc = 'Perform a code action' }) -- Selects a code action
    xnoremap('<Leader>ca', function() vim.lsp.buf.range_code_action() end,
        { buffer = bufnr, desc = 'Perform a code action' })                                                              -- "" for a range
end

return M
