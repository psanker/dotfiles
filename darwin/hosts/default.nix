{
  inputs,
  nixpkgs,
  nixpkgs-unstable,
  home-manager,
  darwin,
  nixvim,
  ...
}: {
  # Work computer
  STSFVFGW093Q6LR = let
    system = "aarch64-darwin";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };

    unstable = import nixpkgs-unstable {
      inherit system;
      config.allowUnfree = true;
    };
    vars = import ./work/vars.nix;
  in
    darwin.lib.darwinSystem {
      inherit system;
      specialArgs = {
        inherit inputs system pkgs unstable vars;
      };
      modules = [
        nixvim.nixDarwinModules.nixvim
        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.sharedModules = [
            inputs.sops-nix.homeManagerModules.sops
          ];
        }

        ./configuration.nix
        ./work
      ];
    };
}
