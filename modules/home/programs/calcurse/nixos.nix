{
  config,
  lib,
  pkgs,
  vars,
  ...
}: {
  config = let
    hmcfg = config.home-manager.users.${vars.user};
    xdgBinHome = "${hmcfg.home.homeDirectory}/.local/bin";
  in
    lib.mkIf config.myopts.programs.calcurse.enable {
      systemd.user.services.calcursecfgwriter = {
        script = ''
          exec ${xdgBinHome}/nix-calcurse-caldav-config
        '';
        serviceConfig = {
          Type = "oneshot";
        };
      };
    };
}
