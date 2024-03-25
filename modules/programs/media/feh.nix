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
      programs.feh.enable = true;
      xdg.mimeApps.defaultApplications = lib.mkIf hmcfg.xdg.mimeApps.enable {
        "image/*" = ["feh.desktop"];
      };
    };
  };
}
