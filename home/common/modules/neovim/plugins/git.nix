{
  fugitive.enable = true;
  gitsigns = {
    enable = true;
    settings = {
      signs = {
        add.text = "+";
        change.text = "Δ";
        delete.text = "_";
        topdelete.text = "‾";
        changedelete.text = "~";
        untracked.text = "┆";
      };
      on_attach = builtins.readFile ./lua/gitsigns-attach.lua;
    };
  };
}
