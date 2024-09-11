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
      programs.mpv.enable = true;
      xdg.mimeApps.defaultApplications = lib.mkIf hmcfg.xdg.mimeApps.enable {
        "video/*" = "mpv.desktop";
      };
    };
  };
}
