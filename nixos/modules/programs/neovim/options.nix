{vars, ...}: {
  mouse = "nv";

  tabstop = 4;
  shiftwidth = 4;
  softtabstop = 4;
  expandtab = true;

  termguicolors = true;
  number = true;
  relativenumber = true;
  hlsearch = false;
  incsearch = true;
  smartindent = true;

  # Better undo/swap support
  swapfile = false;
  backup = false;
  undodir = "${vars.homeDir}/.local/share/nvim/undo";
  undofile = true;

  # UI
  cursorline = true;
  laststatus = 3;
  winbar = "%{%v:lua.require'nvim-navic'.get_location()%}";
  scrolloff = 8;

  # Split defaults
  splitright = true;
  splitbelow = true;

  # Set completeopt to have a better completion experience
  #  :help completeopt
  #  menuone: popup even when there's only one match
  #  noinsert: Do not insert text until a selection is made
  #  noselect: Do not select, force to select one from the menu
  #  shortmess: avoid showing extra messages when using completion
  #  updatetime: set updatetime for CursorHold
  completeopt = ["menuone" "noselect" "noinsert"];
  updatetime = 50;

  # Better which-key support
  timeout = true;
  timeoutlen = 500;
}
