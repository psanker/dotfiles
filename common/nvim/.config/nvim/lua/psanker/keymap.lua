local M = {}

local function bind(op, outer_opts)
    outer_opts = outer_opts or { noremap = true }
    return function(lhs, rhs, opts)
        opts = vim.tbl_extend("force",
            outer_opts,
            opts or {}
        )
        vim.keymap.set(op, lhs, rhs, opts)
    end
end

local function local_bind(op, outer_opts)
    outer_opts = outer_opts or { noremap = true }
    return function(lhs, rhs, opts)
        opts = vim.tbl_extend("force",
            outer_opts,
            opts or {}
        )
        vim.api.nvim_buf_set_keymap(0, op, lhs, rhs, opts)
    end
end

M.nmap = bind("n", { noremap = false })
M.vmap = bind("v", { noremap = false })
M.nnoremap = bind("n")
M.vnoremap = bind("v")
M.xnoremap = bind("x")
M.inoremap = bind("i")

M.buf_nmap = local_bind("n", { noremap = false })
M.buf_nnoremap = local_bind("n")
M.buf_vnoremap = local_bind("v")
M.buf_xnoremap = local_bind("x")
M.buf_inoremap = local_bind("i")

-- Disable the popup menu
M.nmap('<RightMouse>', '<nop>')
M.vmap('<RightMouse>', '<nop>')

function M.bind_lsp_keymaps(_, bufnr)
    local opts = { buffer = bufnr }
    local conform = require('conform')

    local format = vim.lsp.buf.format

    if conform ~= nil then
        format = function(args)
            local new_args = vim.tbl_extend(
                "force",
                args,
                { lsp_fallback = true }
            )

            conform.format(new_args)
        end
    end

    M.nnoremap('=', function() format({ async = true }) end, opts)
    M.nnoremap('K', vim.lsp.buf.hover, { buffer = bufnr, desc = 'Display hover information of symbol under cursor' })
    M.nnoremap('gd', function() vim.lsp.buf.definition() end,
        { buffer = bufnr, desc = 'Go to definition of symbol under cursor' })                                              -- Jump to the definition
    M.nnoremap('gD', function() vim.lsp.buf.declaration() end,
        { buffer = bufnr, desc = 'Go to declaration of symbol under cursor' })                                             -- Jump to the declaration
    M.nnoremap('gi', function() vim.lsp.buf.implementation() end,
        { buffer = bufnr, desc = 'List all implementations of symbol under cursor' })                                      -- Lists all implementations of symbol
    M.nnoremap('go', function() vim.lsp.buf.type_definition() end,
        { buffer = bufnr, desc = 'Go to type definition of symbol under cursor' })                                         -- Jump to def of symbol
    M.nnoremap('gr', function() vim.lsp.buf.references() end,
        { buffer = bufnr, desc = 'List all references of symbol under cursor' })                                           -- List all references
    M.nnoremap('<C-h>', function() vim.lsp.signature_help() end,
        { buffer = bufnr, desc = 'Display signature of symbol under cursor' })                                             -- Displays function signature
    M.inoremap('<C-h>', function() vim.lsp.buf.signature_help() end,
        { buffer = bufnr, desc = 'Display signature of symbol under cursor' })                                             -- Displays function signature
    M.nnoremap('<Leader>r', function() vim.lsp.buf.rename() end, { buffer = bufnr, desc = 'Rename symbol under cursor' })  -- Renames all references of symbol
    M.nnoremap('<Leader>ca', function() vim.lsp.buf.code_action() end, { buffer = bufnr, desc = 'Perform a code action' }) -- Selects a code action
    M.xnoremap('<Leader>ca', function() vim.lsp.buf.code_action() end,
        { buffer = bufnr, desc = 'Perform a code action' })                                                                -- "" for a range
end

return M
