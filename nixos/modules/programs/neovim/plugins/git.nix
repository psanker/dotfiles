{
  fugitive.enable = true;
  gitsigns = {
    enable = true;
    signs = {
      add.text = "+";
      change.text = "Δ";
      delete.text = "_";
      topdelete.text = "‾";
      changedelete.text = "~";
      untracked.text = "┆";
    };
    onAttach = {
      function = builtins.readFile ./lua/gitsigns-attach.lua;
    };
  };
}
