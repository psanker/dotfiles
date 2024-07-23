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
    usingLinux = !pkgs.stdenv.isDarwin;
    xdgDataHome =
      if hmcfg.xdg.enable
      then hmcfg.xdg.dataHome
      else "${hmcfg.home.homeDirectory}/.local/share";
    xdgConfigHome =
      if hmcfg.xdg.enable
      then hmcfg.xdg.configHome
      else "${hmcfg.home.homeDirectory}/.config";
    xdgBinHome = "${hmcfg.home.homeDirectory}/.local/bin";
    sopsSecrets =
      if !usingLinux
      then hmcfg.sops.secrets
      else config.sops.secrets;
  in
    lib.mkIf config.myopts.taskwarrior.enable {
      home = {
        packages = with pkgs; [
          python3
          taskwarrior-tui
          timewarrior
        ];

        file."${xdgConfigHome}/task/hooks/on-modify.sh" = {
          source = ./on-modify.timewarrior;
          executable = true;
        };

        file."${xdgConfigHome}/task/hooks/on-exit-sync.sh" = {
          text = ''
            #!/bin/sh

            check_internet() {
              # 1.1.1.1 is the cloudflare DNS
              ${pkgs.netcat}/bin/nc -z 1.1.1.1 53 &>/dev/null 2>&1

              if [ $? != 0 ]; then
                exit 0
              fi
            }

            n=0

            while read modified_task; do
              n=$((n + 1))
            done

            if [ $n != 0 ]; then
              check_internet

              log_file=${xdgDataHome}/task/sync_hook.log

              date >> $log_file
              ${hmcfg.programs.taskwarrior.package}/bin/task rc.verbose:nothing sync >> $log_file &
            fi
          '';

          executable = true;
        };

        file."${xdgBinHome}/taskrcwriter" = {
          executable = true;
          text = ''
            #!/bin/sh

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
        };
      };
      programs.taskwarrior = {
        enable = true;
        config = {
          data.location = "${xdgDataHome}/task";
          hooks.location = "${xdgConfigHome}/task/hooks";
        };
      };
    };
}
