local set = vim.opt
local g = vim.g

g.loaded = 1
g.loaded_netrwPlugin = 1

-- Global settings
g.mapleader = ' '

set.tabstop = 4
set.shiftwidth = 4
set.softtabstop = 4
set.expandtab = true

set.termguicolors = true
set.number = true
set.relativenumber = true
set.hlsearch = false
set.smartindent = true

set.cursorline = true
set.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"

-- Whitespace chars for diagnostics
set.listchars:append { eol = '¬', tab = '>~', trail = '~', extends = '>', precedes = '<', space = '␣' }
vim.nohls = true

-- Split defaults
set.splitright = true
set.splitbelow = true

--Set completeopt to have a better completion experience
-- :help completeopt
-- menuone: popup even when there's only one match
-- noinsert: Do not insert text until a selection is made
-- noselect: Do not select, force to select one from the menu
-- shortness: avoid showing extra messages when using completion
-- updatetime: set updatetime for CursorHold
set.completeopt = { 'menuone', 'noselect', 'noinsert' }
set.shortmess = vim.opt.shortmess + { c = true }
set.updatetime = 250

-- Better R settings
vim.cmd [[let R_csv_app = 'terminal:vd' ]]
vim.cmd [[let R_assign = 0 ]]
vim.cmd [[let R_nvim_wd = 1]]

-- Show line diagnostics automatically in hover
vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]

