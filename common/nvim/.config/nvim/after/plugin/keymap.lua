local Remap = require("psanker.keymap")

local nmap = Remap.nmap
local nnoremap = Remap.nnoremap
local vnoremap = Remap.vnoremap
local xnoremap = Remap.xnoremap

-- 0. General --
nnoremap('<Leader>bd', ':%bd|e#<CR>|:bd#<CR>')
nnoremap('<Leader>bp', '<cmd> echo expand("%:p")<CR>')
nnoremap('XX', '<cmd>call delete(@%) | bdelete!<CR><cmd>qa!<CR>') -- Equivalent to ZZ but for deletion of file

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

-- 1. View different windows
nnoremap('<Leader>vo', '<cmd>AerialToggle<CR>', { desc = '[v]iew [o]utline' })

-- 2. Quickfix commands
nnoremap(']x', '<cmd>cnext<CR>', { desc = 'Go to next quickfi[x]' })
nnoremap('[x', '<cmd>cprevious<CR>', { desc = 'Go to previous quickfi[x]' })

-- 3. Note capture and quick actions (q) --
nnoremap('<Leader>qn', '<cmd>FloatermNew! --cwd=~/personal/pkm ~/.local/bin/quick-note.sh<CR>',
    { desc = 'Open a [q]uick note in a floating term' })
nnoremap('<Leader>qj', '<cmd>FloatermNew! --cwd=~/personal/pkm ~/.local/bin/quick-journal.sh<CR>',
    { desc = 'Open a [q]uick journal entry in a floating term' })
