let
  user = "pickles";
  system = "x86_64-linux";
  userHome = "/home/${user}";
  flakeDir = "${userHome}/workspace/dotfiles";
in {
  inherit user system;

  locale = "en_US.UTF-8";
  kbdLayout = "us";
  kbdVariant = "";
  tz = "America/New_York";
  shell = "zsh"; # Possible options: bash, zsh
  kernel = "zen"; # Possible options: default, latest, lqx, xanmod, zen
};
