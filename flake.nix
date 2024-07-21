{
  description = "Nix Configuration";

  inputs = {
    # Primary Nix channel
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";

    # Unstable for some things (like eza)
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home manager primarily for user programs
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # NixOS User Repository
    nur.url = "github:nix-community/NUR";

    # Neovim and it's the same but it's configured with Nix so it's not
    nixvim = {
      url = "github:nix-community/nixvim/nixos-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim-unstable = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    hyprland = {
      url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    };

    # Apple's fonts
    apple-fonts = {
      url = "github:Lyndeno/apple-fonts.nix";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    flake-utils.url = "github:numtide/flake-utils";

    # SOPS integration so we can better handle secrets management
    # without the need of crazy submodule structures
    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    # musnix for Linux music-making
    musnix = {
      url = "github:musnix/musnix";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    nixvim,
    nixvim-unstable,
    home-manager,
    nur,
    flake-utils,
    sops-nix,
    musnix,
    ...
  } @ inputs:
    (let
      vars = {
        user = "pickles";
        target = "maris";
      };
    in let
      nixosConfigurations = import ./nixos/hosts {
        inherit (nixpkgs) lib;
        inherit inputs nixpkgs nixpkgs-unstable;
        inherit nixvim-unstable home-manager nur nixvim vars;
      };

      postBuildBundle = import ./nixos/scripts/post-build.nix {
        inherit self nixpkgs flake-utils;
      };
    in {
      inherit (postBuildBundle.bundle) packages;
      inherit (postBuildBundle.bundle) apps;

      inherit nixosConfigurations;
    })
    // (flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {inherit system;};
    in {
      formatter = pkgs.alejandra;
    }));
}
