{
  qjournal,
  qnote,
}: (import ./fugitive.nix
  ++ import ./floaterm.nix {inherit qjournal qnote;}
  ++ import ./harpoon.nix
  ++ import ./oil.nix
  ++ import ./telescope.nix
  ++ import ./views.nix
  ++ import ./zk.nix
  ++ [
    {
      key = "<Leader>bd";
      action = ":%bd|e#<CR>|:bd#<CR>";
      options.desc = "[b]uffers: [d]elete all other buffers";
    }

    {
      key = "<Leader>bp";
      action = "<CMD>echo expand(\"%:p\")<CR>";
      options.desc = "[b]uffers: show the full [p]ath of the current buffer";
    }

    {
      key = "XX";
      action = "<CMD>call delete(@%) | bdelete!<CR><CMD>qa!<CR>";
      options.desc = "Quit Vim AND delete file, if it exists";
    }

    # View centering with jumps
    {
      key = "<C-d>";
      action = "<C-d>zz";
    }

    {
      key = "<C-u>";
      action = "<C-u>zz";
    }

    {
      key = "<C-o>";
      action = "<C-o>zz";
    }

    {
      key = "<C-i>";
      action = "<C-i>zz";
    }

    {
      key = "{";
      action = "{zz";
    }

    {
      key = "}";
      action = "}zz";
    }

    {
      key = "n";
      action = "nzz";
    }

    {
      key = "N";
      action = "Nzz";
    }

    {
      key = "<Leader>x";
      action = "<CMD>!chmod +x %<CR>";
      options.desc = "Make file e[x]ecutable";
    }

    {
      key = "<Leader>p";
      action = "\"_dP";
      options.desc = "Overwrite paste, keeping originally yanked text in register";
      mode = "x";
    }

    {
      key = "Y";
      action = "yg$";
      options.desc = "Yank until end of line";
    }

    {
      key = "<Leader>y";
      action = "\"+y";
      options.desc = "Yank to system clipboard";
      mode = ["n" "v"];
    }

    {
      key = "<Leader>Y";
      action = "\"+Y";
      options.desc = "Yank until end of line to clipboard";
      options.remap = true;
    }

    {
      key = "<Leader>d";
      action = "\"_d";
      options.desc = "Delete text without preserving in register";
      mode = ["n" "v"];
    }

    {
      key = "J";
      action = ":m '>+1<CR>gv=gv";
      mode = "v";
    }

    {
      key = "K";
      action = ":m '<-2<CR>gv=gv";
      mode = "v";
    }
  ])
