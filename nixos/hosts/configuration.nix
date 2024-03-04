{ pkgs, vars, ...}:
let
  terminal = pkgs.${vars.terminal};
in
{
  system.stateVersion = "23.11"; # DO NOT TOUCH

  environment.systemPackages = with pkgs; [
     terminal wget curl git libvirt polkit_gnome go
     tmux networkmanagerapplet vim playerctl
     udiskie mako hyprpaper
  ];

  fonts.packages = with pkgs; [
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
