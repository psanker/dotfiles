{
  config,
  lib,
  vars,
  ...
}: {
  config = let
    hmcfg = config.home-manager.users.${vars.user};
    usingLinux = config.myopts.platform.linux;
    xdgDataHome = if hmcfg.xdg.enable then hmcfg.xdg.dataHome else "${hmcfg.home.homeDirectory}/.local/share";
    xdgConfigHome = if hmcfg.xdg.enable then hmcfg.xdg.configHome else "${hmcfg.home.homeDirectory}/.config";
    sopsSecrets = config.sops.secrets;
  in {
    home-manager.users.${vars.user} = {
      programs.taskwarrior = {
        enable = true;
        config = {
          data.location = "${xdgDataHome}/task";
          hooks.location = "${xdgConfigHome}/task/hooks";
        };
      };
    };

    systemd.services.${vars.user} = lib.mkIf usingLinux {
      script = ''
        echo "
        taskd.server=$(cat ${sopsSecrets."taskwarrior/taskd/server".path})
        " >> ./taskrc
      '';
      serviceConfig = {
        User = vars.user;
        WorkingDirectory = "${xdgConfigHome}/task";
      };
    };
  };
}
