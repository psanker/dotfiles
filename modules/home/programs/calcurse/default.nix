{
  config,
  lib,
  pkgs,
  vars,
  ...
}: {
  imports = let
    platformCfg =
      if pkgs.stdenv.isDarwin
      then ./darwin.nix
      else ./nixos.nix;
  in [platformCfg];

  options = {
    myopts.programs.calcurse.enable = lib.mkEnableOption "Enable calcurse";
  };

  config = let
    hmcfg = config.home-manager.users.${vars.user};
    xdgBinHome = "${hmcfg.home.homeDirectory}/.local/bin";
    xdgConfigHome =
      if hmcfg.xdg.enable
      then hmcfg.xdg.configHome
      else "${hmcfg.home.homeDirectory}/.config";
    xdgDataHome =
      if hmcfg.xdg.enable
      then hmcfg.xdg.dataHome
      else "${hmcfg.home.homeDirectory}/.local/share";
    sopsSecrets = config.sops.secrets;
  in
    lib.mkIf config.myopts.programs.calcurse.enable {
      home-manager.users.${vars.user} = {
        home.file = {
          "${xdgBinHome}/nix-calcurse-caldav-config" = {
            text = ''
              #!/bin/sh

              caldavHome="${xdgConfigHome}/calcurse/caldav"

              if [ ! -d "$caldavHome" ]; then
                mkdir -p "$caldavHome"
              fi

              cat "$caldavHome/config-before" > "$caldavHome/config"
              cat ${sopsSecrets."calcurse/oauth".path} >> "$caldavHome/config"
            '';
            executable = true;
          };
          "${xdgConfigHome}/calcurse/caldav/config-before".text = ''
            [General]
            Binary = ${pkgs.calcurse}/bin/calcurse
            Hostname = apidata.googleusercontent.com
            Path = /caldav/v2/psa251@nyu.edu/events/
            AuthMethod = oauth2
            InsecureSSL = No
            HTTPS = Yes
            SyncFilter = cal
            DryRun = no

          '';
          "${xdgConfigHome}/calcurse/hooks/post-save" = {
            text = ''
              #!/bin/sh
              data_dir="$HOME/.calcurse"
              config_dir="$HOME/.calcurse"

              if [ ! -d "$data_dir" ]; then
                data_dir="${xdgDataHome}/calcurse"
                config_dir="${xdgConfigHome}/calcurse"
              fi

              # Do not do anything when synchronizing with a CalDAV server.
              [ -f "$data_dir/caldav/lock" ] && exit

              # Optionally run the CalDAV synchronization script in the background.
              cd "$data_dir" || exit
              if [ -d caldav ] && command -v calcurse-caldav >/dev/null; then
                (
                  date="$(date +'%b %d %H:%M:%S')"
                  echo "$date Running calcurse-caldav from the post-save hook..."
                  calcurse-caldav
                  echo
                ) >>caldav/log 2>&1 &
              fi
            '';
            executable = true;
          };
        };

        home.packages = with pkgs; [
          calcurse
        ];
      };
    };
}
