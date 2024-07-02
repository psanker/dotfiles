{
  inputs,
  config,
  pkgs,
  vars,
  lib,
  ...
}: let
  terminal = pkgs.${vars.terminal};
in {
  imports =
    import ../../modules/programs
    ++ import ../../modules/utilities
    ++ [
      ../../modules/secrets
    ];

  options = {
    myopts.platform = with lib; mkOption {
      type = types.enum ["nixos" "macos"];
      example = "macos";
      description = "Which platform we're currently using";
    };
  };

  config = {
    system.stateVersion = "23.11";
    myopts.platform = "macos";
    myopts.rebuild.target = "darwin";

    home-manager.users.${vars.user} = {
      launchd = {
        enable = true;
      };
    };
  };
}
