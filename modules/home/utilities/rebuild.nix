{
  vars,
  pkgs,
  ...
}: {
  config = let
    platformString =
      if pkgs.stdenv.isDarwin
      then "darwin"
      else "nixos";
    rebuildTarget = "${platformString}-post-build";
  in {
    # Custom rebuild
    home-manager.users.${vars.user} = {
      home.file.".local/bin/rebuild" = {
        enable = true;
        text = ''
          #!/usr/bin/env bash

          while getopts ':B' OPTION; do
            case "$OPTION" in
            b)
              NO_POST_BUILD=1
              ;;
            ?)
              echo "Usage: $(basename $0) [-B]"
              echo "Args:"
              echo "-B: Do not run post-build scripts"
              exit 1
              ;;
            esac
          done

          shift $(( $OPTIND - 1 ))

          pushd ${vars.flakeDir} &> /dev/null

          sudo ${platformString}-rebuild switch --flake .

          if [ $? = 0 ] && [ -z $NO_POST_BUILD ]; then
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
