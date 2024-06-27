#
#  These are the different profiles that can be used when building NixOS.
#
#  flake.nix
#   └─ ./hosts
#       ├─ default.nix *
#       ├─ configuration.nix  # Common configuration stuff
#       └─ ./<host>.nix
#           └─ default.nix
#
{
  inputs,
  nixpkgs,
  nixpkgs-unstable,
  home-manager,
  nur,
  nixvim,
  ...
}: let
  system = "x86_64-linux"; # System Architecture

  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true; # Allow Proprietary Software
  };

  unstable = import nixpkgs-unstable {
    inherit system;
    config.allowUnfree = true;
  };

  lib = nixpkgs.lib;

  vars = import ./maris/vars.nix;
in {
  maris = lib.nixosSystem {
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
