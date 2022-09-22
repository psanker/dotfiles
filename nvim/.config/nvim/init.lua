local paq = require("paq")

paq {
  "savq/paq-nvim";
  'neovim/nvim-lspconfig';

  'tpope/vim-fugitive';
  'airblade/vim-gitgutter';
  'kyazdani42/nvim-web-devicons';

  'nvim-lualine/lualine.nvim';
  'tpope/vim-surround';
  'tpope/vim-commentary';
  'tpope/vim-repeat';
  'dense-analysis/ale';
  'andymass/vim-matchup';
  'nvim-lua/plenary.nvim';
  'nvim-telescope/telescope.nvim';

  'akinsho/bufferline.nvim';
  'ThePrimeagen/harpoon';

  'kyazdani42/nvim-tree.lua';
  'jalvesaq/Nvim-R';

  'ellisonleao/gruvbox.nvim';
  { 'nvim-treesitter/nvim-treesitter',
    run = function() require('nvim-treesitter.install').update({ with_sync = true }) end };

  -- Completion tools
  'hrsh7th/nvim-cmp';

  -- LSP completion source:
  'hrsh7th/cmp-nvim-lsp';

  -- Useful completion sources:
  'hrsh7th/cmp-nvim-lua';
  'hrsh7th/cmp-nvim-lsp-signature-help';
  'hrsh7th/cmp-vsnip';
  'hrsh7th/cmp-path';
  'hrsh7th/cmp-buffer';
  'hrsh7th/vim-vsnip';

  -- Mainly for inlay hints for Rust
  'simrat39/rust-tools.nvim';
}

local set = vim.opt
local g = vim.g

g.loaded = 1
g.loaded_netrwPlugin = 1

-- Global settings
g.mapleader = ' '

set.tabstop = 2
set.shiftwidth = 2
set.softtabstop = 2
set.expandtab = true

set.termguicolors = true
set.number = true
set.relativenumber = true
set.hlsearch = false
set.smartindent = true

set.cursorline = true

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
vim.api.nvim_set_option('updatetime', 300)

-- Fixed column for diagnostics to appear
-- Show autodiagnostic popup on cursor hover_range
-- Goto previous / next diagnostic warning / error
-- Show inlay_hints more frequently
vim.cmd([[
set signcolumn=yes
autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
]])

-- Plugin Setup --
require('bufferline').setup {}
require("nvim-tree").setup()
require('gruvbox').setup({
  italic = false,
  invert_selection = false,
})
require('lualine').setup({
  options = {
    theme = 'gruvbox_dark'
  }
})
require('nvim-treesitter.configs').setup({
  ensure_installed = { 'r', 'rust', 'python' },
  highlight = {
    enable = true
  },
})

local lsp_defaults = {
  flags = {
    debounce_text_changes = 150,
  },
  capabilities = require('cmp_nvim_lsp').update_capabilities(
    vim.lsp.protocol.make_client_capabilities()
  ),
  on_attach = function(client, bufnr)
    vim.api.nvim_exec_autocmds('User', { pattern = 'LspAttached' })
  end
}

local lspconfig = require('lspconfig')

lspconfig.util.default_config = vim.tbl_deep_extend(
  'force',
  lspconfig.util.default_config,
  lsp_defaults
)

lspconfig.r_language_server.setup({})
lspconfig.sumneko_lua.setup({
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { 'vim' },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
})

local rt = require('rust-tools')
rt.setup({})

local cmp = require('cmp')
cmp.setup({
  -- Enable LSP snippets
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    -- Add tab support
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<C-S-f>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    })
  },
  -- Installed sources:
  sources = {
    { name = 'path' }, -- file paths
    { name = 'nvim_lsp', keyword_length = 3 }, -- from language server
    { name = 'nvim_lsp_signature_help' }, -- display function signatures with current parameter emphasized
    { name = 'nvim_lua', keyword_length = 2 }, -- complete neovim's Lua runtime API such vim.lsp.*
    { name = 'buffer', keyword_length = 2 }, -- source current buffer
    { name = 'vsnip', keyword_length = 2 }, -- nvim-cmp source for vim-vsnip
    { name = 'calc' }, -- source for math calculation
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
})

require('telescope').setup({
  defaults = {
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
      '--hidden',
      '--glob=!.git'
    }
  },
  pickers = {
    find_files = {
      find_command = {
        'rg',
        '--files',
        '--hidden',
        '--glob=!.git'

      }
    }
  }
})
require('telescope').load_extension('harpoon')

-- Keymaps
vim.keymap.set('n', '˜', ':NvimTreeToggle<CR>')
vim.keymap.set('n', '<Leader>bd', ':%bd|e#<CR>|:bd#<CR>')
vim.keymap.set('n', '<Leader>c', '<cmd> source ~/.config/nvim/init.lua<CR>')

-- better viewing after jumps
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', 'n', 'nzz')
vim.keymap.set('n', 'N', 'Nzz')
vim.keymap.set('n', '<Leader>x', '<cmd>! chmod +x %<CR>', { silent = true })
vim.keymap.set('n', '{', '{zz')
vim.keymap.set('n', '}', '}zz')

-- better yanking/pasting
vim.keymap.set('x', '<Leader>p', '"_dP')
vim.keymap.set('n', 'Y', 'yg$')

vim.keymap.set('n', '<Leader>y', '"+y')
vim.keymap.set('v', '<Leader>y', '"+y')
vim.keymap.set('n', '<Leader>Y', '"+Y', { noremap = false })

vim.keymap.set('n', '<Leader>d', '"_d')
vim.keymap.set('v', '<Leader>d', '"_d')

vim.keymap.set('n', '<Leader>fr', function() vim.lsp.buf.formatting() end)

-- Telescope
vim.keymap.set('n', '<Leader>ff', '<cmd> lua require("telescope.builtin").find_files()<CR>')
vim.keymap.set('n', '<Leader>fg', '<cmd> lua require("telescope.builtin").live_grep()<CR>')
vim.keymap.set('n', '<Leader>fb', '<cmd> lua require("telescope.builtin").buffers()<CR>')
vim.keymap.set('n', '<Leader>fh', '<cmd> lua require("telescope.builtin").help_tags()<CR>')

-- easy pairs
vim.keymap.set('i', "'", "''<Esc>ha")
vim.keymap.set('i', '"', '""<Esc>ha')
vim.keymap.set('i', '(', '()<Esc>ha')
vim.keymap.set('i', '[', '[]<Esc>ha')
vim.keymap.set('i', '{', '{}<Esc>ha')

-- Harpoon maps
vim.keymap.set('n', '<Leader>hh', '<cmd> lua require("harpoon.ui").toggle_quick_menu()<CR>')
vim.keymap.set('n', '<Leader>ha', '<cmd> lua require("harpoon.mark").add_file()<CR>')
vim.keymap.set('n', '<Leader>hn', '<cmd> lua require("harpoon.ui").nav_next()<CR>')
vim.keymap.set('n', '<Leader>hp', '<cmd> lua require("harpoon.ui").nav_prev()<CR>')

vim.keymap.set('n', '<Leader>hq', '<cmd> lua require("harpoon.ui").nav_file(1)<CR>')
vim.keymap.set('n', '<Leader>hw', '<cmd> lua require("harpoon.ui").nav_file(2)<CR>')
vim.keymap.set('n', '<Leader>he', '<cmd> lua require("harpoon.ui").nav_file(3)<CR>')
vim.keymap.set('n', '<Leader>hr', '<cmd> lua require("harpoon.ui").nav_file(4)<CR>')

-- Theme config
set.background = 'dark'
vim.cmd([[colorscheme gruvbox]])

-- For R, read .lintr if it exists
vim.cmd([[
if filereadable('.lintr')
  let g:ale_r_lintr_options = join(readfile('.lintr'))
endif
]])

-- Better R settings
vim.cmd [[let R_csv_app = 'terminal:vd' ]]
vim.cmd [[let R_assign = 0 ]]
vim.cmd [[let R_nvim_wd = 1]]

vim.diagnostic.config({
  virtual_text = false
})

-- Show line diagnostics automatically in hover window
set.updatetime = 250
vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]

-- Autocomplete settings
vim.api.nvim_create_autocmd('User', {
  pattern = 'LspAttached',
  desc = 'LSP actions',
  callback = function()
    local bufmap = function(mode, lhs, rhs)
      local opts = { buffer = true }
      vim.keymap.set(mode, lhs, rhs, opts)
    end

    -- Displays hover information about the symbol under the cursor
    bufmap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>')

    -- Jump to the definition
    bufmap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>')

    -- Jump to declaration
    bufmap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')

    -- Lists all the implementations for the symbol under the cursor
    bufmap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>')

    -- Jumps to the definition of the type symbol
    bufmap('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>')

    -- Lists all the references
    bufmap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>')

    -- Displays a function's signature information
    bufmap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<cr>')

    -- Renames all references to the symbol under the cursor
    bufmap('n', '<Leader>r', '<cmd>lua vim.lsp.buf.rename()<cr>')

    -- Selects a code action available at the current cursor position
    bufmap('n', '<Leader>q', '<cmd>lua vim.lsp.buf.code_action()<cr>')
    bufmap('x', '<Leader>q', '<cmd>lua vim.lsp.buf.range_code_action()<cr>')

    -- Show diagnostics in a floating window
    bufmap('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')

    -- Move to the previous diagnostic
    bufmap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')

    -- Move to the next diagnostic
    bufmap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>')
  end
})
