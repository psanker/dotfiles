{
  config,
  lib,
  vars,
  ...
}: {
  config = {
    programs.feh.enable = true;
    xdg.mimeApps.defaultApplications = lib.mkIf config.xdg.mimeApps.enable {
      "image/*" = ["feh.desktop"];
    };
  };
}
