{
  config,
  lib,
  pkgs,
  vars,
  ...
}: {
  config = let
    hmcfg = config.home-manager.users.${vars.user};
  in
    # Requires GPG module to be enabled
    # because it also handles pass
    lib.mkIf config.myopts.programs.gpg.enable {
      home-manager.users.${vars.user} = {
        programs.neomutt = {
          enable = true;
          sort = "reverse-threads";
          vimKeys = true;
        };
      };
    };
}
