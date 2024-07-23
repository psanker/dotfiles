{
  treesitter = {
    enable = true;
    nixvimInjections = true;
    folding = false;
    indent = true;
    nixGrammars = true;
    ensureInstalled = "all";
    incrementalSelection.enable = true;
  };

  ts-context-commentstring = {
    enable = true;
  };

  treesitter-textobjects = {
    enable = true;
  };
}
