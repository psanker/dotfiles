{
  config,
  lib,
  pkgs,
  vars,
  ...
}: {
  options = {
    myopts.services.music.enable = lib.mkEnableOption "Enable Linux music-making systems/services";
  };

  config = let
    usingLinux = config.myopts.platform.linux;
  in
    lib.mkIf (usingLinux && config.myopts.services.music.enable) {
      musnix.enable = true;

      home-manager.users.${vars.user} = {
        home.packages = with pkgs; [
          ardour
          qjackctl
        ];
      };
    };
}
