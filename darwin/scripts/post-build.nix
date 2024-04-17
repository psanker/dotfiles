{
  self,
  nixpkgs,
  flake-utils,
  ...
}: let
  binName = "darwin-post-build";
in {
  bundle = flake-utils.lib.eachDefaultSystem (system: let
    pkgs = import nixpkgs {inherit system;};
  in {
    packages.${binName} = pkgs.writeScriptBin binName ''
      # Put something here when ready
    '';

    apps.${binName} = {
      type = "app";
      program = "${self.packages.${system}.${binName}}/bin/${binName}";
    };
  });
}
