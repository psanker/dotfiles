local set = vim.opt
local g = vim.g

g.loaded = 1
g.loaded_netrwPlugin = 1
g.syntax_on = 1
g.inactive_buf_syntax = 0

-- Global settings
g.mapleader = ' '
set.mouse = 'nv'

set.tabstop = 4
set.shiftwidth = 4
set.softtabstop = 4
set.expandtab = true

-- Better undo/swap support
set.swapfile = false
set.backup = false
set.undodir = os.getenv("HOME") .. "/.local/share/nvim/undo"
set.undofile = true

set.termguicolors = true
set.number = true
set.relativenumber = true
set.hlsearch = false
set.incsearch = true
set.smartindent = true

set.cursorline = true
set.laststatus = 3
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
-- shortmess: avoid showing extra messages when using completion
-- updatetime: set updatetime for CursorHold
set.completeopt = { 'menuone', 'noselect', 'noinsert' }
set.shortmess = vim.opt.shortmess + { c = true }
set.updatetime = 50

-- Better R settings
vim.cmd [[let R_csv_app = 'terminal:vd' ]]
vim.cmd [[let R_cmd = 'R' ]]
vim.cmd [[let R_app = 'radian' ]]
vim.cmd [[let R_assign = 0 ]]
vim.cmd [[let R_nvim_wd = 1]]


-- Vimwiki stuff
g.vimiwiki_list = {
    {
        path = '~/workspace/dt-handbook/',
        syntax = 'markdown',
        ext = '.qmd'
    }
}

-- Markdown things
g.mkdp_port = 8800
g.mkdp_page_title = '${name} - md.nvim'
g.mkdp_auto_start = 0

-- zen-mode and neovim bug workaround
g.zen_mode_open = false

-- Which-key help
set.timeout = true
set.timeoutlen = 500
