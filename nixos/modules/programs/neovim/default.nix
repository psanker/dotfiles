{
  pkgs,
  vars,
  ...
}: {
  config = {
    programs.nixvim = {
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
      plugins = import ./plugins;
      extraPlugins = with pkgs.vimPlugins; [
        luasnip

        ## User interface
        #  Since my statusline is interconnected with
        #  zen-mode, I need to pull these and configure manually
        (pkgs.vimUtils.buildVimPlugin rec {
          # I need the actual lua code for the statusline and theme
          pname = "rose-pine";
          version = "14b371fb783a8cfdade04544fb782f0bb6f7c904";
          src = pkgs.fetchFromGitHub {
            owner = "rose-pine";
            repo = "neovim";
            rev = version;
            sha256 = "sha256-MA1le+hIMpm7uqx4UsJLE+iuySX4VDgDjqxfRBgZa2Y=";
          };
        })

        (pkgs.vimUtils.buildVimPlugin rec {
          pname = "zen-mode";
          version = "78557d972b4bfbb7488e17b5703d25164ae64e6a";
          src = pkgs.fetchFromGitHub {
            owner = "folke";
            repo = "zen-mode.nvim";
            rev = version;
            sha256 = "sha256-G5/AskXEA0vl9GGUR8NG8PmL/HFcItZJWB+LyKd3R2k=";
          };
        })
      ];
      extraConfigLua = builtins.readFile ./lua/interface.lua;
    };
  };
}
