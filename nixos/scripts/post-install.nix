{
  self,
  nixpkgs,
  flake-utils,
  ...
}: let
  binName = "nixos-post-install";
in {
  bundle = flake-utils.lib.eachDefaultSystem (system: let
    pkgs = import nixpkgs {inherit system;};
  in {
    packages.${binName} = pkgs.writeScriptBin binName ''
      systemctl --user start taskrcwriter.service
    '';

    apps.${binName} = {
      type = "app";
      program = "${self.packages.${system}.${binName}}/bin/${binName}";
    };
  });
}
