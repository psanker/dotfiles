{
  description = "Nix Configuration";

  inputs = {
    # Primary Nix channel
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";

    # Unstable for some things (like eza)
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home manager primarily for user programs
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # NixOS User Repository
    nur.url = "github:nix-community/NUR";

    # Neovim but configured with Nix
    nixvim = {
      url = "github:nix-community/nixvim/nixos-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim-unstable = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    # Apple's fonts
    apple-fonts = {
      url = "github:Lyndeno/apple-fonts.nix";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    nixvim,
    nixvim-unstable,
    home-manager,
    hyprland,
    nur,
    flake-utils,
    ...
  } @ inputs:
    (let
      vars = {
        user = "pickles";
      };
    in {
      nixosConfigurations = import ./nixos/hosts {
        inherit (nixpkgs) lib;
        inherit inputs nixpkgs nixpkgs-unstable;
        inherit nixvim-unstable home-manager nur nixvim hyprland vars;
      };
    })
    // (flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {inherit system;};
    in {
      formatter = pkgs.alejandra;
    }));
}
