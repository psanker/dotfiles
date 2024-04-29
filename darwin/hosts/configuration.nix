{inputs, pkgs, vars, lib, ...}:
let
  terminal = pkgs.${vars.terminal};
in {
  imports =
    import ../../modules/programs
    ++ import ../../modules/utilities
    ++ [
      ../../modules/secrets
    ];

  options = {
    myopts.platform.macos = lib.mkEnableOption "Whether we're on macOS or not";
  };

  config = {
    system.stateVersion = "23.11";
    myopts.platform.macos = true;
    myopts.rebuild.target = "darwin";

    # Nix Stuff
    nix = {
      settings = {
        auto-optimise-store = true;
      };
      gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 7d";
      };
      package = pkgs.nixVersions.unstable; # Enable Flakes
      registry.nixpkgs.flake = inputs.nixpkgs;
      extraOptions = ''
        experimental-features = nix-command flakes
        keep-outputs          = true
        keep-derivations      = true
      '';
    };
    nixpkgs.config.allowUnfree = true;

    environment = {
      variables = {
        TERMINAL = "${vars.terminal}";
        EDITOR = "${vars.editor}";
        VISUAL = "${vars.editor}";
      };
      systemPackages = with pkgs; [
        terminal

        curl
        firefox
        git
        gh
        go
        htop-vim
        jq
        kitty
        neofetch # For the lols
        rsync
        signal-desktop
        sops
        tmux
        vim
        wget
      ];
    };

    services = {
      nix-daemon.enable = true;
    };
  };
}
