{
  pkgs,
  vars,
  ...
}: {
  config = {
    programs.fish.enable = true; # Needed for the Wezterm shell
    home-manager.users.${vars.user}.programs = {
      wezterm = {
        extraConfig = ''
          local wez = require('wezterm')
          local cfg = {}

          -- Window
          cfg.enable_tab_bar = false
          cfg.window_padding = {
              left = '2cell',
              right = '2cell',
              top = '1cell',
              bottom = '0cell',
          }
          cfg.window_background_opacity = 0.97

          -- Testing this out...
          cfg.enable_wayland = false

          -- Font
          cfg.font = wez.font_with_fallback {
              'Hasklug Nerd Font Mono',
              'Hasklug Nerd Font',
              'SF Mono',
              'SF Pro',
              'JetBrains Mono',
          }
          -- Theme
          cfg.color_scheme = 'rose-pine-moon'

          -- Shell
          cfg.default_prog = { "${pkgs.fish}", "-l" }

          -- Autoreload
          cfg.automatically_reload_config = true

          return cfg
        '';
      };
    };
  };
}
