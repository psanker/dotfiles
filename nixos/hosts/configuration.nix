{
  inputs,
  pkgs,
  vars,
  ...
}: let
  terminal = pkgs.${vars.terminal};
in {
  imports = import ../modules/programs;
  system.stateVersion = "23.11"; # DO NOT TOUCH

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

      alsa-utils
      coreutils
      curl
      feh
      firefox
      git
      go
      htop-vim
      jq
      killall
      kitty
      lf
      nano
      networkmanagerapplet
      playerctl
      polkit_gnome
      rsync
      tmux
      udiskie
      unzip
      vim
      wget
      xdg-utils
      zip
    ];
  };

  fonts = {
    packages = with pkgs; [
      carlito
      vegur
      source-code-pro
      jetbrains-mono
      font-awesome
      corefonts
      (nerdfonts.override {
        fonts = [
          "FiraCode"
        ];
      })
    ];
  };

  home-manager.users.${vars.user} = {
    home = {
      stateVersion = "23.11";
    };
    programs = {
      home-manager.enable = true;
    };
    xdg = {
      mime.enable = true;
      mimeApps = {
        enable = true;
        defaultApplications = {
          "image/jpeg" = ["feh.desktop"];
          "image/png" = ["feh.desktop"];
          "image/tiff" = ["feh.desktop"];
          "text/plain" = "nvim.desktop";
          "text/html" = "nvim.desktop";
          "text/csv" = "nvim.desktop";
        };
      };
    };
  };

  i18n = {
    defaultLocale = vars.locale;
    extraLocaleSettings = {
      LC_ADDRESS = vars.locale;
      LC_IDENTIFICATION = vars.locale;
      LC_MEASUREMENT = vars.locale;
      LC_MONETARY = vars.locale;
      LC_NAME = vars.locale;
      LC_NUMERIC = vars.locale;
      LC_PAPER = vars.locale;
      LC_TELEPHONE = vars.locale;
      LC_TIME = vars.locale;
    };
  };

  networking = {
    inherit (vars) hostName;
    networkmanager.enable = true;
  };

  security = {
    polkit.enable = true;
    rtkit.enable = true;
  };
}
