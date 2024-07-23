{lib, inputs, pkgs, unstable, vars, ...}:
{
  imports = [
    inputs.sops-nix.homeManagerModules.sops
  ];

  config = {
    myopts = {
      programs = {
        git.enable = lib.mkDefault true;
        gpg.enable = lib.mkDefault true;
        kitty.enable = lib.mkDefault true;
        nixvim.enable = lib.mkDefault true;
        sioyek.enable = lib.mkDefault true;
        taskwarrior.enable = lib.mkDefault true;
      };
    };

    home-manager = {
      useUserPackages = true;
      useGlobalPackages = true;
      extraSpecialArgs = {
        inherit inputs pkgs unstable vars;
      };
    };
  };
}
