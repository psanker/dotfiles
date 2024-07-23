{
  config,
  lib,
  ...
}: {
  options = {
    myopts.programs.gpg.enable = lib.mkEnableOption "Whether Home Manager controls GPG";
  };

  config = let
    xdgConfigHome =
      if config.xdg.enable
      then config.xdg.configHome
      else "${config.home.homeDirectory}/.config";
    sopsSecrets = config.sops.secrets;
    gpgImporterScript = ''
      cat ${sopsSecrets."gpg/keyring".path} | base64 -d | ${config.programs.gpg.package}/bin/gpg --import
    '';
    gpgImporterScriptFile = "${config.home.homeDirectory}/.local/bin/gpgimporter.sh";
  in lib.mkIf config.myopts.programs.gpg.enable {
      home.file.${gpgImporterScriptFile} = {
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
  };
}
