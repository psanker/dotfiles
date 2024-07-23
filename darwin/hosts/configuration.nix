{
  inputs,
  system,
  config,
  pkgs,
  vars,
  lib,
  ...
}: let
  terminal = pkgs.${vars.terminal};
  platformStr = sys: let
    sys_split = builtins.split "-" sys;
    sys_rev = lib.lists.reverseList sys_split;
  in
    builtins.head sys_rev;
in {
  imports =
    import ../../modules/programs
    ++ import ../../modules/utilities
    ++ [
      ../../modules/secrets
    ];

  options = {
    myopts.platform = with lib;
      mkOption {
        type = types.str;
        example = "macos";
        description = "Which platform we're currently using";
      };
  };

  config = {
    system.stateVersion = "23.11";
    myopts.platform = platformStr system;
    myopts.rebuild.target = "darwin";

    home-manager.users.${vars.user} = {
      home = {
        stateVersion = "23.11";
      };

      launchd = {
        enable = true;
      };
    };
  };
}
