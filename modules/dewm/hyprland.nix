{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  options = {
    myopts.dewm.hyprland.enable = with lib;
      mkOption {
        type = types.bool;
        default = false;
        example = true;
        description = "Whether to enable Hyprland on this machine";
      };
  };

  config = lib.mkIf config.myopts.dewm.hyprland.enable {
    # So we don't have to rebuild Hyprland each time
    nix.settings = {
      substituters = ["https://hyprland.cachix.org"];
      trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
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
        grimblast # Screenshot
        socat # Needed for Hyprland IPC
        swayidle # Idle Daemon
        swaylock # Lock Screen
        wl-clipboard # Clipboard
        wlr-randr # Monitor Settings
        xwayland # X session
      ];
    };

    programs.hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      xwayland.enable = true;
    };

    xdg.portal = {
      enable = true;
      configPackages = [
        pkgs.xdg-desktop-portal-gtk
        pkgs.xdg-desktop-portal-hyprland
        pkgs.xdg-desktop-portal
      ];
      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
        pkgs.xdg-desktop-portal
      ];
      wlr.enable = true;
    };
  };
}
