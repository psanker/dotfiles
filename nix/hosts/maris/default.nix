{ pkgs, config, inputs, options, ... }:

let 
  opts = import ./options.nix;
in
{
  imports =
    [
      ./hardware.nix
    ];

  # Enable Flake support
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "23.11"; # Did you read the comment?

  ## ALPHABETICAL ORDER STARTING NOW ##  

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  environment.systemPackages = with pkgs; [
     wget curl git libvirt polkit_gnome go
     tmux networkmanagerapplet vim playerctl
     udiskie mako hyprpaper
  ];

  hardware = {
    bluetooth.enable = true;
    bluetooth.powerOnBoot = true;

    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };

    pulseaudio.enable = false; # We usin' Pipewire boisss
  };

  i18n = {
    defaultLocale = opts.locale;

    extraLocaleSettings = {
      LC_ADDRESS = opts.locale;
      LC_IDENTIFICATION = opts.locale;
      LC_MEASUREMENT = opts.locale;
      LC_MONETARY = opts.locale;
      LC_NAME = opts.locale;
      LC_NUMERIC = opts.locale;
      LC_PAPER = opts.locale;
      LC_TELEPHONE = opts.locale;
      LC_TIME = opts.locale;
    };
  };

  networking = {
    inherit (opts) hostName;
    networkmanager.enable = true;
  };

  programs = {
    dconf.enable = true;
    hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.system}.hyprland;
      xwayland.enable = true;
    };
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    thunar.enable = true;
  };

  security = {
    pam.services.swaylock = {
      text = ''
        auth include login
      '';
    };
    polkit.enable = true;
    rtkit.enable = true;
  };

  services = {
    blueman.enable = true;
    flatpak.enable = true;
    gnome.gnome-keyring.enable = true;
    openssh.enable = true;

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    printing = {
      enable = true;
    };

    # All of X and its glory
    xserver = {
      enable = true;

      layout = "us";
      xkbVariant = "";

      displayManager.sddm = {
        enable = true;
        wayland.enable = true;
      };
    };
  };

  sound.enable = true;

  systemd = {
    services.flatpak-repo = {
      wantedBy = [ "multi-user.target" ];
      path = [ pkgs.flatpak ];
      script = ''
        flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
      '';
    };

    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };

  time.timeZone = opts.tz;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${opts.user} = {
    isNormalUser = true;
    description = "Patrick Anker";
    extraGroups = [ "networkmanager" "wheel" "audio" "video" ];
    packages = with pkgs; [
      bat
      cargo
      eww-wayland
      firefox
      fish
      fzf
      kitty
      neovim
      nerdfonts
      ripgrep
      rustup
      starship
      stow
      wezterm
    #  thunderbird
    ];
  };

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal
    ];
    configPackages = [ pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal
    ];
  };
}
