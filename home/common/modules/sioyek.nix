{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    myopts.programs.sioyek.enable = lib.mkEnableOption "Whether to use sioyek or not";
  };

  config = lib.mkIf config.myopts.programs.sioyek.enable {
    programs.sioyek = {
      enable = true;
      bindings = {
        screen_down = "<C-d>";
        screen_up = "<C-u>";
        close_window = "q";
        quit = "Q";
      };
    };

    xdg = lib.mkIf (config.xdg.mimeApps.enable && !pkgs.stdenv.isDarwin) {
      mimeApps = {
        defaultApplications = {
          "application/pdf" = "sioyek.desktop";
        };
      };
    };
  };
}
