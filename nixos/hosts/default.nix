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

{ lib, inputs, nixpkgs, nixpkgs-unstable, home-manager, nur, nixvim, hyprland, vars, ... }:

let
  system = "x86_64-linux";                                  # System Architecture

  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;                              # Allow Proprietary Software
  };

  unstable = import nixpkgs-unstable {
    inherit system;
    config.allowUnfree = true;
  };

  lib = nixpkgs.lib;
in
{
  maris = lib.nixosSystem {                         # Personal laptop
    inherit system;
    specialArgs = {                                 # Pass Flake Variable
      inherit inputs system pkgs unstable hyprland vars;
      host = {
        hostName = "maris";
      };
    };
    modules = [                                             # Modules Used
      nur.nixosModules.nur
      nixvim.nixosModules.nixvim
      ./maris
      ./configuration.nix

      home-manager.nixosModules.home-manager {              # Home-Manager Module
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
      }
    ];
  };
}
