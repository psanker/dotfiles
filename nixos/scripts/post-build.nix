{
  self,
  nixpkgs,
  flake-utils,
  ...
}: let
  binName = "linux-post-build";
in {
  bundle = flake-utils.lib.eachDefaultSystem (system: let
    pkgs = import nixpkgs {inherit system;};
  in {
    packages.${binName} = pkgs.writeScriptBin binName ''
      #!/usr/bin/env bash
      
      systemctl --user start taskrcwriter.service
      systemctl --user start gpgimporter.service

      ${(import ../../modules/scripts/post-build.nix).sync-pass}
    '';

    apps.${binName} = {
      type = "app";
      program = "${self.packages.${system}.${binName}}/bin/${binName}";
    };
  });
}
