{
  config,
  lib,
  pkgs,
  vars,
  ...
}: {
  config = let
    hmcfg = config.home-manager.users.${vars.user};
    qjournal = ".local/bin/quick-journal.sh";
    qnote = ".local/bin/quick-note.sh";
  in {
    programs.nixvim =
      {
        enable = true;
        autoCmd = import ./autocmd;
        globals = {
          syntax = true;
          mapleader = " ";

          # Custom thingies
          zen_mode_open = false;
        };
        options = import ./options.nix {
          inherit vars;
        };
        keymaps = import ./keymaps {inherit qjournal qnote;};
        extraConfigLua = ''
          ${builtins.readFile ./lua/interface.lua}

          ${builtins.readFile ./lua/lsp-helper.lua}

          ${builtins.readFile ./lua/nvimr.lua}
        '';
      }
      // import ./plugins {inherit pkgs;};

    home-manager.users.${vars.user} = {
      home.file = {
        ${qjournal} = {
          text = ''
            #!/usr/bin/env bash
            nvim -c 'ZkNew {dir = "journal", group = "journal"}'
          '';
          executable = true;
        };
        ${qnote} = {
          text = ''
            EDITOR=nvim
            zk new --template=default.md notes
          '';
          executable = true;
        };
      };
      xdg.mimeApps.defaultApplications = lib.mkIf hmcfg.xdg.mimeApps.enable {
        "text/plain" = "nvim.desktop";
        "text/html" = "nvim.desktop";
      };
    };
  };
}
