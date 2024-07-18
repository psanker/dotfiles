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
    usingLinux = config.myopts.platform == "linux";
    usingMacos = config.myopts.platform == "macos";
    xdgConfigHome =
      if hmcfg.xdg.enable
      then hmcfg.xdg.configHome
      else "${hmcfg.home.homeDirectory}/.config";
    sopsSecrets = config.sops.secrets;
    gpgImporterScript = ''
      cat ${sopsSecrets."gpg/keyring".path} | base64 -d | ${hmcfg.programs.gpg.package}/bin/gpg --import
    '';
    gpgImporterScriptMacosLocation = "${hmcfg.home.homeDirectory}/.local/bin/gpgimporter.sh";
  in {
    myopts.programs.gpg.enable = true;

    home-manager.users.${vars.user} = {
      home.file.${gpgImporterScriptMacosLocation} = {
        text = ''
          #!/bin/sh
          ${gpgImporterScript}
        '';
        executable = true;
      };

      programs.password-store.enable = true;

      programs.gpg = {
        enable = true;
        homedir = "${xdgConfigHome}/gnupg";
      };

      programs.git.signing = lib.mkIf config.myopts.programs.git.enable {
        key = "BF9AB14D3B994BB1";
        signByDefault = true;
      };

      launchd = lib.mkIf usingMacos {
        agents."com.patrickanker.nix.gpgimporter" = {
          enable = true;
          config = {
            LaunchOnlyOnce = true;
            RunAtLoad = true;
            Program = gpgImporterScriptMacosLocation; # Lord, this is starting to look like Obj-C
          };
        };
      };
    };

    systemd.user.services.gpgimporter = lib.mkIf usingLinux {
      script = gpgImporterScript;
      serviceConfig = {
        Type = "oneshot";
      };
    };
  };
}
