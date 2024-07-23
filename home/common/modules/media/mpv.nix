{
  config,
  lib,
  ...
}: {
  config = {
    programs.mpv.enable = true;
    xdg.mimeApps.defaultApplications = lib.mkIf config.xdg.mimeApps.enable {
      "video/*" = "mpv.desktop";
    };
  };
}
