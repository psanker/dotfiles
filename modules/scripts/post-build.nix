{
  self,
  nixpkgs,
  flake-utils,
  lib,
  ...
}: {
  bundle = flake-utils.lib.eachDefaultSystem (system: let
    pkgs = import nixpkgs {inherit system;};
    platformStr = sys: let
      sys_split = builtins.split "-" sys;
      sys_rev = lib.lists.reverseList sys_split;
    in
      builtins.head sys_rev;
    binName = "${platformStr system}-post-build";
    syncPass = ''
      if [ -n $(command -v pass) ]; then
        if [ ! -d "$HOME/.password-store" ]; then
          pushd $HOME &> /dev/null;

          git clone git@github.com:psanker/passwords.git .password-store

          popd &> /dev/null;
        else
          pass git pull -q
        fi
      fi
    '';
    scheduledTasks =
      if (platformStr system) == "linux"
      then ''
        systemctl --user start taskrcwriter.service
        systemctl --user start gpgimporter.service
      ''
      else ''

      '';
  in {
    packages.${binName} = pkgs.writeScriptBin binName ''
      ${scheduledTasks}

      ${syncPass}
    '';

    apps.${binName} = {
      type = "app";
      program = "${self.packages.${system}.${binName}}/bin/${binName}";
    };
  });
}
