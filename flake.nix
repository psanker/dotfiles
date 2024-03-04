{
  description = "Nix Configuration";

  inputs = {
    # Primary Nix channel
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";

    # Unstable for some things (like eza)
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home manager primarily for user programs
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # NixOS User Repository
    nur.url = "github:nix-community/NUR"

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

  };

  outputs = { self, nixpkgs, nixpkgs-unstable, nixvim, nixvim-unstable, home-manager, ... }@inputs:
    let
      vars = {
        user = "pickles";
        name = "Patrick Anker";
        email = "patricksanker@gmail.com";
        terminal = "wezterm";
        editor = "nvim";
      };
    in
    {
      nixosConfigurations = import ./nixos/hosts {
        inherit (nixpkgs) lib;
        inherit inputs nixpkgs nixvim-unstable home-manager nur nixvim hyprland var;
      };
    };
}
