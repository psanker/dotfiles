rec {
  system = "x86_64-darwin";
  user = "patrickanker";
  hostName = "iliad";
  shell = "zsh";
  terminal = "wezterm";
  homeDir = "/Users/${user}";
  flakeDir = "${homeDir}/workspace/dotfiles";
  name = "Patrick Anker";
  email = "patricksanker@gmail.com";
}
