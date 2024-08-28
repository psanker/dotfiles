{
  vars,
  pkgs,
  ...
}: {
  config.home-manager.users.${vars.user} = {
    programs.kitty = {
      enable = true;
      font = {
        name = "Hasklug Nerd Font Mono";
        package = pkgs.nerdfonts.override {
          fonts = ["Hasklig"];
        };
        size = 12;
      };
      settings = {
        # Show underlying characters in ligatures when working with them
        disable_ligatures = "cursor";

        # Window things
        window_padding_width = 10;
        background_opacity = "0.97";

        # MacOS Stuff
        macos_option_as_alt = "left";
        macos_show_window_title_in = "none";
        hide_window_decorations = "titlebar-only";

        # Theme
        foreground = "#e0def4";
        background = "#232136";
        selection_foreground = "#e0def4";
        selection_background = "#44415a";

        cursor = "#56526e";
        cursor_text_color = "#e0def4";

        url_color = "#c4a7e7";

        active_tab_foreground = "#e0def4";
        active_tab_background = "#393552";
        inactive_tab_foreground = "#6e6a86";
        inactive_tab_background = "#232136";

        # black
        color0 = "#393552";
        color8 = "#6e6a86";

        # red
        color1 = "#eb6f92";
        color9 = "#eb6f92";

        # green
        color2 = "#3e8fb0";
        color10 = "#3e8fb0";

        # yellow
        color3 = "#f6c177";
        color11 = "#f6c177";

        # blue
        color4 = "#9ccfd8";
        color12 = "#9ccfd8";

        # magenta=
        color5 = "#c4a7e7";
        color13 = "#c4a7e7";

        # cyan
        color6 = "#ea9a97";
        color14 = "#ea9a97";

        # white
        color7 = "#e0def4";
        color15 = "#e0def4";
      };
    };
  };
}