{
  config,
  lib,
  vars,
  inputs,
  system,
  ...
}: {
  options = {
    myopts.programs.rofi.enable = with lib;
      mkOption {
        type = types.bool;
        default = true;
        example = true;
        description = "Whether to enable Rofi";
      };
  };

  config = let
    rofiEnabled = config.myopts.programs.rofi.enable;
    pkgs = import inputs.nixpkgs {
      inherit system;
      overlays = [
        (new: old: {
          rofi-calc = old.rofi-calc.override {
            rofi-unwrapped = old.rofi-wayland-unwrapped;
          };
        })
      ];
    };
  in
    lib.mkIf (!pkgs.stdenv.isDarwin && rofiEnabled) {
      home.packages = with pkgs; [
        rofimoji
      ];
      programs.rofi = {
        enable = true;
        package = pkgs.rofi-wayland;
        plugins = with pkgs; [
          rofi-calc
        ];

        extraConfig = {
          hide-scrollbar = true;
          kb-cancel = "Escape,Control+bracketleft";
          kb-mode-next = "Alt+Right,Shift+Right,Control+Tab,Alt+l";
          kb-mode-previous = "Alt+Left,Shift+Left,Control+ISO_Left_Tab,Alt+h";
          modi = "drun,run,emoji:${pkgs.rofimoji}/bin/rofimoji,calc";
          monitor = "-4";
        };

        theme = ./rose-pine-moon.rasi;
      };
    };
}
