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
      colorschemes = import ./colorscheme.nix;
      options = import ./options.nix {
        inherit vars;
      };
      keymaps = import ./keymaps;
      plugins = import ./plugins;
      extraPlugins = with pkgs.vimPlugins; [
        luasnip
      ];
    };
  };
}
