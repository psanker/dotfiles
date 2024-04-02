{
  config,
  pkgs,
  vars,
  lib,
  ...
}: {
  options = {
    myopts.programs.git.enable = with lib;
      mkOption {
        type = types.bool;
        default = true;
        example = true;
        description = "Whether to enable the git module";
      };
  };

  config = let
    gitEnabled = config.myopts.programs.git.enable;
  in {
    home-manager.users.${vars.user} = lib.mkIf gitEnabled {
      programs.git = {
        enable = true;

        package = pkgs.git;

        userName = vars.name;
        userEmail = vars.email;

        aliases = {
          lg1 = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)' --all";
          lg2 = "lg2 = log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(auto)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)'";
          lg = "lg1";
        };

        extraConfig = {
          init = {
            defaultBranch = "main";
          };

          rerere.enable = true;
          rebase.updateRefs = true;
        };
      };
    };
  };
}
