{
  inputs,
  pkgs,
  unstable,
  vars,
  lib,
  ...
}: let
  terminal = pkgs.${vars.terminal};
in {
  imports =
    import ../../modules/programs
    ++ import ../../modules/dewm
    ++ import ../../modules/services
    ++ import ../../modules/utilities
    ++ [
      ../../modules/secrets
    ];

  options = {
    # FIXME: use `pkgs.stdenv.isDarwin` instead
    myopts.platform.linux = with lib;
      mkOption {
        type = types.bool;
        default = false;
        example = true;
        description = mdDoc "Whether we're on Linux or not";
      };
  };

  config = {
    system.stateVersion = "23.11"; # DO NOT TOUCH
    myopts.platform.linux = true;
    myopts.rebuild.target = "nixos";

    myopts.programs.calcurse.enable = lib.mkDefault true;

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
      package = pkgs.nixVersions.git; # Enable Flakes
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
        unstable.firefox
        git
        gh
        go
        htop-vim
        jq
        killall
        kitty
        nano
        neofetch # For the lols
        networkmanagerapplet
        pavucontrol
        playerctl
        polkit_gnome
        rsync
        unstable.signal-desktop
        sops
        tmux
        unzip
        usbutils
        vim
        wget
        xdg-user-dirs
        xdg-utils
        zip
      ];
    };

    fonts = {
      packages =
        (with pkgs; [
          carlito
          vegur
          source-code-pro
          jetbrains-mono
          font-awesome
          corefonts
          (nerdfonts.override {
            fonts = [
              "FiraCode"
              "Hasklig"
            ];
          })
        ])
        ++ (with inputs; [
          apple-fonts.packages.${pkgs.system}.sf-pro
          apple-fonts.packages.${pkgs.system}.sf-mono
          apple-fonts.packages.${pkgs.system}.ny
        ]);
    };

    home-manager.users.${vars.user} = {
      home = {
        stateVersion = "23.11";
        packages = with pkgs; [
          libnotify
          spotify
        ];
      };
      gtk = {
        enable = true;
        theme = {
          name = "rose-pine-moon";
          package = pkgs.rose-pine-gtk-theme;
        };
      };
      dconf.settings = {
        "org/gnome/desktop/interface" = {
          color-scheme = "prefer-dark";
        };
      };
      programs = {
        home-manager.enable = true;
      };
      xdg = {
        mime.enable = true;
        mimeApps = {
          enable = true;
          defaultApplications = {
            "text/csv" = "libreoffice.desktop";
          };
        };
      };
      services.udiskie = {
        enable = true;
        automount = true;
        tray = "auto";
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

    # USB mounting support
    services = {
      devmon.enable = true;
      gvfs.enable = true;
      udisks2.enable = true;
    };
  };
}
