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
    local open = false

    return function()
        open = not open

        if open then
            vim.cmd [[Git]]
        else
            vim.cmd [[Git]]
            vim.cmd [[q]]
        end
    end
end

local f_state = fugitive_state()

nnoremap('<Leader>gg', f_state, { silent = true, desc = 'Toggle fu[g]itive window' })
nnoremap('<Leader>gp', '<cmd>Git pull<CR>', { silent = true, desc = '[g]it [p]ull' })
nnoremap('<Leader>gP', '<cmd>Git push<CR>', { silent = true, desc = '[g]it [P]ush' })
nnoremap('<Leader>gl', '<cmd>Git log<CR>', { desc = '[g]it [l]og' })

-- 3. Telescope (f) --
local builtin = require("telescope.builtin")
nnoremap('<Leader>fb', '<cmd>NvimTreeToggle<CR>', { desc = '[f]ile [b]rowser' })
nnoremap('<Leader>ff', builtin.find_files, { desc = "[f]ind [f]ile" })
nnoremap('<Leader>fw', builtin.grep_string, { desc = "[f]ind [w]ord under cursor" })
nnoremap('<Leader>fg', builtin.live_grep, { desc = "[f]ind string using [g]rep" })
nnoremap('<Leader>ft', function()
    local tag = vim.fn.input("Tag > ")
    builtin.grep_string({ search = ":" .. tag .. ":" })
end, { desc = "[f]ind vimwiki-style [t]ag" })
nnoremap('<Leader>fk', '<cmd> Telescope keymaps<CR>', { desc = '[f]ind [k]eymap' })

nnoremap('<Leader>/', builtin.current_buffer_fuzzy_find,
    { desc = "Find in current buffer using fuzzy find (akin to [/])" })
nnoremap('<Leader>f?', builtin.help_tags, { desc = "[f]ind in help[?]" })
nnoremap('<Leader>fs', builtin.lsp_document_symbols, { desc = "[f]ind [s]ymbol in current document" })
nnoremap('<Leader>fS', builtin.lsp_workspace_symbols, { desc = "[f]ind [S]ymbol in current workspace" })

-- 4. Harpoon (h) --
nnoremap('<Leader>hh', '<cmd> lua require("harpoon.ui").toggle_quick_menu()<CR>')
nnoremap('<Leader>ha', '<cmd> lua require("harpoon.mark").add_file()<CR>')
nnoremap('<Leader>hn', '<cmd> lua require("harpoon.ui").nav_next()<CR>')
nnoremap('<Leader>hp', '<cmd> lua require("harpoon.ui").nav_prev()<CR>')

nnoremap('<Leader>hq', '<cmd> lua require("harpoon.ui").nav_file(4)<CR>')
nnoremap('<Leader>hw', '<cmd> lua require("harpoon.ui").nav_file(3)<CR>')
nnoremap('<Leader>he', '<cmd> lua require("harpoon.ui").nav_file(2)<CR>')
nnoremap('<Leader>hr', '<cmd> lua require("harpoon.ui").nav_file(1)<CR>')

-- 5. View different windows
nnoremap('<Leader>vo', '<cmd>SymbolsOutline<CR>')
nnoremap('<Leader>vt', '<cmd>TodoTrouble<CR>')
nnoremap('<Leader>vT', '<cmd>TodoTelescope<CR>')
nnoremap('<Leader>vx', '<cmd>TroubleToggle<CR>')

-- 6. Zen mode --
nnoremap('<Leader>zz', '<cmd>NoNeckPain<CR>')

-- 7. Undo Tree --
nnoremap('<Leader>u', '<cmd>UndotreeToggle<CR>')

-- 8. Note capture and quick actions (q) --
nnoremap('<Leader>qn', '<cmd>FloatermNew! --cwd=~/personal/pkm ~/.local/bin/quick-note.sh<CR>')
nnoremap('<Leader>qj', '<cmd>FloatermNew! --cwd=~/personal/pkm ~/.local/bin/quick-journal.sh<CR>')
nnoremap('<Leader>qx', '<cmd>TroubleToggle quickfix<CR>')
