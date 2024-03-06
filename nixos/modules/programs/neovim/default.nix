{
  config,
  lib,
  pkgs,
  vars,
  ...
}: {
  config = let
    hmcfg = config.home-manager.users.${vars.user};
  in {
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

          ${builtins.readFile ./lua/nvimr.lua}
        '';
      }
      // import ./plugins {inherit pkgs;};

    home-manager.users.${vars.user} = {
      xdg.mimeApps.defaultApplications = lib.mkIf hmcfg.xdg.mimeApps.enable {
        "text/plain" = "nvim.desktop";
        "text/html" = "nvim.desktop";
      };
    };
  };
}
