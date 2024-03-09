{
  config,
  lib,
  vars,
  ...
}: {
  options = {
    myopts.rebuild.target = with lib;
      mkOption {
        type = types.enum ["nixos"];
        example = "nixos";
        description = "Which target to select for the rebuild command";
      };
  };

  config = let
    rebuildTarget = "${config.myopts.rebuild.target}-post-install";
  in {
    # Custom rebuild
    home-manager.users.${vars.user} = {
      home.file.".local/bin/rebuild" = {
        enable = true;
        text = ''
          #!/usr/bin/env bash

          pushd ${vars.flakeDir} &> /dev/null

          sudo nixos-rebuild switch --flake .

          if [ $? = 0 ] && [ -z $NO_SECRETS ]; then
            echo "running post-build jobs..."
            nix run .#${rebuildTarget}
          fi

          popd &> /dev/null
        '';
        executable = true;
      };
    };
  };
}
