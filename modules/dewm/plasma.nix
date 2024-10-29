{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    myopts.dewm.plasma.enable = lib.mkEnableOption "Whether to enable KDE Plasma on this machine";
  };

  config = lib.mkIf config.myopts.dewm.plasma.enable {
    services.xserver.enable = true;
    services.displayManager.sddm.enable = true;
    services.desktopManager.plasma6.enable = true;
  };
}
