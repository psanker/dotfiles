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
nnoremap('|', ':!')

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

-- Move visual blocks around!!
vnoremap('J', ":m '>+1<CR>gv=gv")
vnoremap('K', ":m '<-2<CR>gv=gv")

-- 1. LSP --
nnoremap('gl', function() vim.diagnostic.open_float() end) -- Show diagnostics in floating pane
nnoremap('[d', function() vim.diagnostic.goto_prev() end) -- Go to prev diagnositc
nnoremap(']d', function() vim.diagnostic.goto_next() end) -- Go to next diagnostic

-- 2. LazyGit --
nnoremap('<Leader>gg', '<cmd>LazyGit<CR>', { silent = true })

-- 3. Telescope (f) --
local builtin = require("telescope.builtin")
nnoremap('<Leader>ff', builtin.find_files)
nnoremap('<Leader>fg', builtin.live_grep)
nnoremap('<Leader>ft', function ()
    local tag = vim.fn.input("Tag > ")
    builtin.grep_string({search = ":" .. tag .. ":"})
end)

nnoremap('<Leader>fb', builtin.current_buffer_fuzzy_find)
nnoremap('<Leader>f?', builtin.help_tags)
nnoremap('<Leader>fs', builtin.lsp_document_symbols)
nnoremap('<Leader>fS', builtin.lsp_workspace_symbols)

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
nnoremap('<Leader>tt', '<cmd> TodoTrouble<CR>')
nnoremap('<Leader>tT', '<cmd> TodoTelescope<CR>')
nnoremap(']t', function() require('todo-comments').jump_next() end, { desc = "Next TODO comment" })
nnoremap('[t', function() require('todo-comments').jump_prev() end, { desc = "Previous TODO comment" })

-- 7. Zen mode --
nnoremap('<Leader>zz', '<cmd>ZenMode<CR>')
nnoremap('<Leader>zp', '<cmd>SoftPencil<CR>')
nnoremap('<Leader>qp', '<cmd>NoPencil<CR>')

-- 8. Undo Tree --
nnoremap('<Leader>u', '<cmd>UndotreeToggle<CR>')
