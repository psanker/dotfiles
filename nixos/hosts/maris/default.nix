{
  pkgs,
  unstable,
  vars,
  hyprland,
  ...
}: {
  imports = [
    ./hardware.nix
  ];

  myopts.dewm.hyprland.enable = true;

  ## ALPHABETICAL ORDER STARTING NOW ##

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
    timeout = 5;
  };

  environment = let
    exec = "exec dbus-launch Hyprland";
  in {
    loginShellInit = ''
      if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
        ${exec}
      fi
    '';
    variables = {
      XDG_CURRENT_DESKTOP = "Hyprland";
      XDG_SESSION_TYPE = "wayland";
      XDG_SESSION_DESKTOP = "Hyprland";
    };
    systemPackages = with pkgs; [
      light # Backlight controls w/o messing with the sys vars
      pamixer # Messing with sound
    ];
  };

  fonts = {
    fontconfig = {
      defaultFonts = {
        sansSerif = ["SF Pro" "Carlito" "Liberation Sans"];
        serif = ["New York" "Times New Roman" "Liberation Serif"];
        monospace = ["SF Mono" "Source Code Pro" "Liberation Mono"];
      };
    };
  };

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

  home-manager.users.${vars.user} = {
    services.mako.enable = true;
  };

  # So we don't have to rebuild Hyprland each time
  nix.settings = {
    substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };

  programs = {
    dconf.enable = true;
    fish.enable = true;
    hyprland = {
      enable = true;
      package = hyprland.packages.${unstable.system}.hyprland;
      xwayland.enable = true;
    };
    light.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    thunar.enable = true;
  };

  qt = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita-dark";
  };

  security = {
    pam.services.swaylock = {
      text = ''
        auth include login
      '';
    };
  };

  services = {
    auto-cpufreq.enable = true;

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
      wantedBy = ["multi-user.target"];
      path = [pkgs.flatpak];
      script = ''
        flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
      '';
    };

    sleep = {
      extraConfig = ''
        AllowSuspend=yes
        AllowHibernation=no
        AllowSuspendThenHibernate=yes
        AllowHybridSleep=yes
      '';
    };

    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = ["graphical-session.target"];
      wants = ["graphical-session.target"];
      after = ["graphical-session.target"];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };

  time.timeZone = vars.tz;

  users.users.${vars.user} = {
    isNormalUser = true;
    description = vars.userDesc;
    extraGroups = ["networkmanager" "wheel" "audio" "video"];
    packages = with pkgs; [
      cargo
      eww-wayland
      gammastep
      hyprpaper
      libreoffice-qt
      mako
      rofi-wayland
      rofi-calc
      rofimoji
      rustup
    ];
    shell = pkgs.fish;
  };
}
