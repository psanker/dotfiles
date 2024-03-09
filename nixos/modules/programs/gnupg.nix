{config, lib, vars, ...}: {
  config = let
    hmcfg = config.home-manager.users.${vars.user};
    usingLinux = config.myopts.platform.linux;
    xdgConfigHome =
      if hmcfg.xdg.enable
      then hmcfg.xdg.configHome
      else "${hmcfg.home.homeDirectory}/.config";
    sopsSecrets = config.sops.secrets;
  in {
    home-manager.users.${vars.user} = {
      programs.gpg = {
        enable = true;
        homedir = "${xdgConfigHome}/gnupg";
      };
    };

    systemd.user.services.gpgimporter = lib.mkIf usingLinux {
      script = ''
        cat ${sopsSecrets."gpg/keyring".path} | base64 -d | ${hmcfg.programs.gpg.package}/bin/gpg --import
      '';
    };
  };
}
