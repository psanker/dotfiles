{
  config,
  lib,
  vars,
  ...
}: {
  options = {
    myopts.programs.gpg.enable = with lib;
      mkOption {
        type = types.bool;
        default = false;
        example = true;
        description = "Whether Home Manager controls GPG";
      };
  };

  config = let
    hmcfg = config.home-manager.users.${vars.user};
    usingLinux = config.myopts.platform.linux;
    xdgConfigHome =
      if hmcfg.xdg.enable
      then hmcfg.xdg.configHome
      else "${hmcfg.home.homeDirectory}/.config";
    sopsSecrets = config.sops.secrets;
  in {
    myopts.programs.gpg.enable = true;

    home-manager.users.${vars.user} = {
      programs.gpg = {
        enable = true;
        homedir = "${xdgConfigHome}/gnupg";
      };

      programs.git.signing =
        lib.mkIf config.myopts.programs.git.enable {
          key = "BF9AB14D3B994BB1";
          signByDefault = true;
        };
    };

    systemd.user.services.gpgimporter = lib.mkIf usingLinux {
      script = ''
        cat ${sopsSecrets."gpg/keyring".path} | base64 -d | ${hmcfg.programs.gpg.package}/bin/gpg --import
      '';
      serviceConfig = {
        Type = "oneshot";
      };
    };
  };
}
