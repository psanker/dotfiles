{
  pkgs,
  vars,
  lib,
  ...
}: {
  options = {
    myopts.programs.git.enable = with lib;
      mkOption {
        type = types.bool;
        default = false;
        example = true;
        description = "Whether to enable the git module";
      };
  };

  config = {
    myopts.programs.git.enable = true;

    home-manager.users.${vars.user} = {
      programs.git = {
        enable = true;

        package = pkgs.git;

        userName = vars.name;
        userEmail = vars.email;

        extraConfig = {
          init = {
            defaultBranch = "main";
          };

          rerere.enable = true;
        };
      };
    };
  };
}
