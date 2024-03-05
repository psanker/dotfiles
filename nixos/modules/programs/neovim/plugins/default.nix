(import ./lsp.nix
  // import ./noice.nix
  // import ./telescope.nix
  // {
    commentary.enable = true;
    fugitive.enable = true;
    lualine.enable = true;
    navic.enable = true;
    oil.enable = true;
    surround.enable = true;
    treesitter = {
      enable = true;
      nixvimInjections = true;
      folding = false;
      indent = true;
      nixGrammars = true;
      ensureInstalled = "all";
      incrementalSelection.enable = true;
    };
  })
