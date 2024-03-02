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

    # Make Treesitter behave its damn self
    nvim-treesitter.url = "github:nvim-treesitter/nvim-treesitter/v0.9.1";
    nvim-treesitter.flake = false;

    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      # Change this to select the machine to render
      host = "maris";

      inherit (import ./nix/hosts/${host}.nix) system;
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
    
      nixosConfigurations.default = nixpkgs.lib.nixosSystem {
          specialArgs = {inherit inputs;};
          modules = [ 
            ./configuration.nix
            # inputs.home-manager.nixosModules.default
          ];
        };

    };
}
