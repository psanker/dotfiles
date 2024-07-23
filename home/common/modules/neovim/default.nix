{
  config,
  lib,
  pkgs,
  vars,
  inputs,
  ...
}: {
  imports = [ inputs.nixvim.homeManagerModules.nixvim ];

  options = {
    myopts.programs.nixvim.enable = lib.mkEnableOptions "Enable Nixvim module";
  };

  config = let
    qjournal = ".local/bin/quick-journal.sh";
    qnote = ".local/bin/quick-note.sh";
  in lib.mkIf config.myopts.programs.nixvim.enable {
    programs.nixvim =
      {
        enable = true;
        autoCmd = import ./autocmd;
        autoGroups = {
          MyWriting = {
            clear = true;
          };
        };
        globals = {
          syntax = true;
          mapleader = " ";
        };
        opts = import ./opts.nix {
          inherit vars;
        };
        keymaps = import ./keymaps {inherit qjournal qnote;};
        extraConfigLua = ''
          ${builtins.readFile ./lua/interface.lua}

          ${builtins.readFile ./lua/lsp-helper.lua}

          ${builtins.readFile ./lua/nvimr.lua}

          ${builtins.readFile ./lua/writing-helper.lua}
        '';
      }
      // import ./plugins {inherit pkgs;};

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
    xdg.mimeApps.defaultApplications = lib.mkIf config.xdg.mimeApps.enable {
      "text/plain" = "nvim.desktop";
      "text/html" = "nvim.desktop";
    };
  };
}
