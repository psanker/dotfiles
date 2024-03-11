{
  config,
  lib,
  pkgs,
  vars,
  ...
}: {
  config = let
    hmcfg = config.home-manager.users.${vars.user};
    usingLinux = config.myopts.platform.linux;
    xdgConfigHome =
      if hmcfg.xdg.enable
      then hmcfg.xdg.configHome
      else "${hmcfg.home.homeDirectory}/.config";
    xdgCacheHome =
      if hmcfg.xdg.enable
      then hmcfg.xdg.cacheHome
      else "${hmcfg.home.homeDirectory}/.cache";
  in
    # Requires GPG module to be enabled
    # because it also handles pass
    lib.mkIf config.myopts.programs.gpg.enable {
      home-manager.users.${vars.user} = {
        home = {
          file = {
            "${xdgConfigHome}/mutt/switch.muttrc" = {
              source = ./switch.muttrc;
            };

            "${xdgConfigHome}/mutt/accounts/nyu/muttrc" = {
              source = ./accounts/nyu/muttrc;
            };

            "${xdgConfigHome}/mutt/accounts/nyu/signature" = {
              source = ./accounts/nyu/signature;
            };
          };
        };

        programs.neomutt = {
          enable = true;

          extraConfig = ''
            ${builtins.readFile ./mw.muttrc}

            ${builtins.readFile ./accounts/nyu/muttrc}

            ${builtins.readFile ./muttrc}
          '';
        };
      };
    };
}
