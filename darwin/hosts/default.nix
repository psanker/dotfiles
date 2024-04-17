{
  inputs,
  nixpkgs,
  nixpkgs-unstable,
  home-manager,
  darwin,
  nixvim,
  ...
}: let
  lib = nixpkgs.lib;
in
{
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
  in {
  };
}
