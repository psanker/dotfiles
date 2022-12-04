local Remap = require("psanker.keymap")

local nmap = Remap.nmap
local nnoremap = Remap.nnoremap
local vnoremap = Remap.vnoremap
local xnoremap = Remap.xnoremap

-- 0. General --
nnoremap('˜', ':NvimTreeToggle<CR>')
nnoremap('<Leader>bd', ':%bd|e#<CR>|:bd#<CR>')
nnoremap('<Leader>c', '<cmd> source ~/.config/nvim/init.lua<CR>')
nnoremap('<Leader>bp', '<cmd> echo expand("%:p")<CR>')

-- better viewing after jumps
nnoremap('<C-d>', '<C-d>zz')
nnoremap('<C-u>', '<C-u>zz')
nnoremap('<C-o>', '<C-o>zz')
nnoremap('<C-i>', '<C-i>zz')
nnoremap('n', 'nzz')
nnoremap('N', 'Nzz')
nnoremap('<Leader>x', '<cmd>! chmod +x %<CR>', { silent = true })
nnoremap('{', '{zz')
nnoremap('}', '}zz')

-- Hide/show command line
nnoremap('<Leader>cl', function()
  if (vim.o.cmdheight == 0) then
    vim.o.cmdheight = 1
  else
    vim.o.cmdheight = 0
  end
end)

-- better yanking/pasting
xnoremap('<Leader>p', '"_dP')
nnoremap('Y', 'yg$')

nnoremap('<Leader>y', '"+y')
vnoremap('<Leader>y', '"+y')
nmap('<Leader>Y', '"+Y')

nnoremap('<Leader>d', '"_d')
vnoremap('<Leader>d', '"_d')


-- 1. LSP --
nnoremap('<Leader>fr', function() vim.lsp.buf.format({ async = true }) end)
nnoremap('K', function() vim.lsp.buf.hover() end)
nnoremap('gd', function() vim.lsp.buf.definition() end) -- Jump to the definition
nnoremap('gD', function() vim.lsp.buf.declaration() end) -- Jump to the declaration
nnoremap('gi', function() vim.lsp.buf.implementation() end) -- Lists all implementations of symbol
nnoremap('go', function() vim.lsp.buf.type_definition() end) -- Jump to def of symbol
nnoremap('gr', function() vim.lsp.buf.references() end) -- List all references
nnoremap('<C-k>', function() vim.lsp.buf.signature_help() end) -- Displays function signature
nnoremap('<Leader>r', function() vim.lsp.buf.rename() end) -- Renames all references of symbol
nnoremap('<Leader>q', function() vim.lsp.buf.code_action() end) -- Selects a code action
xnoremap('<Leader>q', function() vim.lsp.buf.range_code_action() end) -- "" for a range
nnoremap('gl', function() vim.diagnostic.open_float() end) -- Show diagnostics in floating pane
nnoremap('[d', function() vim.diagnostic.goto_prev() end) -- Go to prev diagnositc
nnoremap(']d', function() vim.diagnostic.goto_next() end) -- Go to next diagnostic

-- 2. LazyGit --
nnoremap('<Leader>gg', '<cmd>LazyGit<CR>', { silent = true })

-- 3. Telescope (f) --
nnoremap('<Leader>ff', function() require("telescope.builtin").find_files() end)
nnoremap('<Leader>fg', function() require("telescope.builtin").live_grep() end)
nnoremap('<Leader>fb', function() require("telescope.builtin").buffers() end)
nnoremap('<Leader>fh', function() require("telescope.builtin").help_tags() end)
nnoremap('<Leader>fs', function() require("telescope.builtin").lsp_document_symbols() end)
nnoremap('<Leader>fS', function() require("telescope.builtin").lsp_workspace_symbols() end)

-- 4. Harpoon (h) --
nnoremap('<Leader>hh', '<cmd> lua require("harpoon.ui").toggle_quick_menu()<CR>')
nnoremap('<Leader>ha', '<cmd> lua require("harpoon.mark").add_file()<CR>')
nnoremap('<Leader>hn', '<cmd> lua require("harpoon.ui").nav_next()<CR>')
nnoremap('<Leader>hp', '<cmd> lua require("harpoon.ui").nav_prev()<CR>')

nnoremap('<Leader>hq', '<cmd> lua require("harpoon.ui").nav_file(4)<CR>')
nnoremap('<Leader>hw', '<cmd> lua require("harpoon.ui").nav_file(3)<CR>')
nnoremap('<Leader>he', '<cmd> lua require("harpoon.ui").nav_file(2)<CR>')
nnoremap('<Leader>hr', '<cmd> lua require("harpoon.ui").nav_file(1)<CR>')

-- 5. Trouble (x) maps --
nnoremap('<Leader>xx', '<cmd> TroubleToggle<CR>')
nnoremap('<Leader>xq', '<cmd> TroubleToggle quickfix<CR>')

-- 6. TODO commments (t) maps --
nnoremap('<Leader>tt', '<cmd> TodoTelescope<CR>')
nnoremap(']t', function() require('todo-comments').jump_next() end, { desc = "Next TODO comment" })
nnoremap('[t', function() require('todo-comments').jump_prev() end, { desc = "Previous TODO comment" })

-- 7. Zen mode --
nnoremap('<Leader>z', '<cmd>ZenMode<CR>')
