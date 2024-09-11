{
  inputs,
  nixpkgs,
  nixpkgs-unstable,
  home-manager,
  nur,
  nixvim,
  ...
}: let
  lib = nixpkgs.lib;
in {
  maris = let
    vars = import ./maris/vars.nix;

    inherit (vars) system;

    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true; # Allow Proprietary Software
    };

    unstable = import nixpkgs-unstable {
      inherit system;
      config.allowUnfree = true;
    };
  in
    lib.nixosSystem {
      # Personal laptop
      inherit system;
      specialArgs = {
        # Pass Flake Variable
        inherit inputs system pkgs unstable vars;
      };
      modules = [
        nur.nixosModules.nur
        nixvim.nixosModules.nixvim
        inputs.musnix.nixosModules.musnix

        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
        }

        ./configuration.nix
        ./maris
      ];
    };
}
