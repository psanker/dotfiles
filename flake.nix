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

    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";

      # Keep Neovim fresh 
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    # Make Treesitter behave its damn self
    nvim-treesitter.url = "github:nvim-treesitter/nvim-treesitter/v0.9.1";
    nvim-treesitter.flake = false;

    hyprland-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};

      overlays = [
        inputs.neovim-nightly-overlay.overlay
      ];
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
