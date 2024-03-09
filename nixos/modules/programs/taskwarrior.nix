{
  config,
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
        echo "
        include "${xdgConfigHome}/task/home-manager-taskrc"
        taskd.server=$(cat ${sopsSecrets."taskwarrior/taskd/server".path})
        taskd.credentials=$(cat ${sopsSecrets."taskwarrior/taskd/credentials".path})
        " > ./taskrc
      '';
      serviceConfig = {
        User = vars.user;
        WorkingDirectory = "${xdgConfigHome}/task";
      };
    };
  };
}
