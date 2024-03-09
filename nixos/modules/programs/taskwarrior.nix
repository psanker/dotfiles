{
  config,
  pkgs,
  lib,
  vars,
  ...
}: {
  options = {
    myopts.taskwarrior.enable = with lib;
      mkOption {
        type = types.bool;
        default = false;
        example = true;
        description = mdDoc "Whether home manager is managing taskwarrior";
      };
  };
  config = let
    hmcfg = config.home-manager.users.${vars.user};
    usingLinux = config.myopts.platform.linux;
    xdgDataHome =
      if hmcfg.xdg.enable
      then hmcfg.xdg.dataHome
      else "${hmcfg.home.homeDirectory}/.local/share";
    xdgConfigHome =
      if hmcfg.xdg.enable
      then hmcfg.xdg.configHome
      else "${hmcfg.home.homeDirectory}/.config";
    sopsSecrets = config.sops.secrets;
  in {
    myopts.taskwarrior.enable = true;

    home-manager.users.${vars.user} = {
      home.packages = with pkgs; [
        taskwarrior-tui
      ];
      programs.taskwarrior = {
        enable = true;
        config = {
          data.location = "${xdgDataHome}/task";
          hooks.location = "${xdgConfigHome}/task/hooks";
        };
      };
    };

    systemd.user.services.taskrcwriter = lib.mkIf usingLinux {
      script = ''
        KEY_FILE="${xdgConfigHome}/task/$(cat ${sopsSecrets."taskwarrior/taskd/key/filename".path})"
        CACERT_FILE="${xdgConfigHome}/task/$(cat ${sopsSecrets."taskwarrior/taskd/cacert/filename".path})"
        CERT_FILE="${xdgConfigHome}/task/$(cat ${sopsSecrets."taskwarrior/taskd/cert/filename".path})"

        echo "
        include "${xdgConfigHome}/task/home-manager-taskrc"
        taskd.server=$(cat ${sopsSecrets."taskwarrior/taskd/server".path})
        taskd.key=$KEY_FILE
        taskd.ca=$CACERT_FILE
        taskd.certificate=$CERT_FILE
        taskd.credentials=$(cat ${sopsSecrets."taskwarrior/taskd/credentials".path})
        " > ./taskrc

        cat ${sopsSecrets."taskwarrior/taskd/key/content".path} | base64 -d >$KEY_FILE
        cat ${sopsSecrets."taskwarrior/taskd/cacert/content".path} | base64 -d >$CACERT_FILE
        cat ${sopsSecrets."taskwarrior/taskd/cert/content".path} | base64 -d >$CERT_FILE

        chmod 600 $KEY_FILE $CACERT_FILE $CERT_FILE
      '';
      serviceConfig = {
        WorkingDirectory = "${xdgConfigHome}/task";
      };
    };
  };
}
