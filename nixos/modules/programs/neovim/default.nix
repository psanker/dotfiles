{
  pkgs,
  vars,
  ...
}: {
  config = {
    programs.nixvim =
      {
        enable = true;
        globals = {
          syntax = true;
          mapleader = " ";

          # Custom thingies
          zen_mode_open = false;
        };
        options = import ./options.nix {
          inherit vars;
        };
        keymaps = import ./keymaps;
        extraConfigLua = ''
          ${builtins.readFile ./lua/interface.lua}

          ${builtins.readFile ./lua/lsp-helper.lua}
        '';
      }
      // import ./plugins {inherit pkgs;};
  };
}
