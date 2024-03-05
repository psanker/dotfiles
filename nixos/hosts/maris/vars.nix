let
  user = "pickles";
  userDesc = "Patrick";
  hostName = "maris";
  system = "x86_64-linux";
in {
  inherit user userDesc hostName system;

  locale = "en_US.UTF-8";
  kbdLayout = "us";
  kbdVariant = "";
  tz = "America/New_York";
  shell = "zsh";
  kernel = "zen";
  editor = "nvim";
  terminal = "kitty";
  homeDir = "/home/${user}";
  name = "Patrick Anker";
  email = "patricksanker@gmail.com";
}
