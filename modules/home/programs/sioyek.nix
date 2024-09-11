{
  config,
  lib,
  vars,
  ...
}: {
  config = let
    hmcfg = config.home-manager.users.${vars.user};
  in {
    home-manager.users.${vars.user} = {
      programs.sioyek = {
        enable = true;
        bindings = {
          screen_down = "<C-d>";
          screen_up = "<C-u>";
          close_window = "q";
          quit = "Q";
        };
      };

      xdg = lib.mkIf hmcfg.xdg.mimeApps.enable {
        mimeApps = {
          defaultApplications = {
            "application/pdf" = "sioyek.desktop";
          };
        };
      };
    };
  };
}
