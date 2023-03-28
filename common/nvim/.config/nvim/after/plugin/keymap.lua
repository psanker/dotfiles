local Remap = require("psanker.keymap")

local nmap = Remap.nmap
local nnoremap = Remap.nnoremap
local vnoremap = Remap.vnoremap
local xnoremap = Remap.xnoremap

-- 0. General --
nnoremap('<Leader>bd', ':%bd|e#<CR>|:bd#<CR>')
nnoremap('<Leader>bp', '<cmd> echo expand("%:p")<CR>')
nnoremap('|', ':!')
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

-- 1. LSP --
nnoremap('gl', function() vim.diagnostic.open_float() end) -- Show diagnostics in floating pane
nnoremap('[d', function() vim.diagnostic.goto_prev() end) -- Go to prev diagnositc
nnoremap(']d', function() vim.diagnostic.goto_next() end) -- Go to next diagnostic

-- 2. Git --
local function fugitive_state()
    vim.g.fugitive_state = not vim.g.fugitive_state

    if vim.g.fugitive_state then
        vim.cmd [[Git]]
    else
        vim.cmd [[Git]]
        vim.cmd [[q]]
    end
end

nnoremap('<Leader>gg', fugitive_state, { silent = true, desc = 'Toggle fu[g]itive window' })
nnoremap('<Leader>gp', '<cmd>Git pull<CR>', { silent = true, desc = '[g]it [p]ull' })
nnoremap('<Leader>gP', '<cmd>Git push<CR>', { silent = true, desc = '[g]it [P]ush' })
nnoremap('<Leader>gl', '<cmd>Git log<CR>', { desc = '[g]it [l]og' })

-- 3. View different windows
nnoremap('<Leader>vo', '<cmd>SymbolsOutline<CR>', { desc = '[v]iew [o]utline' })
nnoremap('<Leader>vt', '<cmd>TodoTrouble<CR>', { desc = '[v]iew [t]odos' })
nnoremap('<Leader>vT', '<cmd>TodoTelescope<CR>', { desc = '[v]iew [T]odos in Telescope' })
nnoremap('<Leader>vx', '<cmd>TroubleToggle<CR>', { desc = '[v]iew quickfi[x]' })

-- 4. Note capture and quick actions (q) --
nnoremap('<Leader>qn', '<cmd>FloatermNew! --cwd=~/personal/pkm ~/.local/bin/quick-note.sh<CR>',
    { desc = 'Open a [q]uick note in a floating term' })
nnoremap('<Leader>qj', '<cmd>FloatermNew! --cwd=~/personal/pkm ~/.local/bin/quick-journal.sh<CR>',
    { desc = 'Open a [q]uick journal entry in a floating term' })
