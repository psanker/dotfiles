{
  config,
  lib,
  pkgs,
  vars,
  ...
}: {
  options = {
    myopts.programs.gpg.enable = with lib;
      mkOption {
        type = types.bool;
        default = false;
        example = true;
        description = "Whether Home Manager controls GPG";
      };
  };

  imports = let
    platformFile =
      if pkgs.stdenv.isDarwin
      then ./darwin.nix
      else ./nixos.nix;
  in
    if config.myopts.programs.gpg.enable
    then [platformFile]
    else [];

  config = let
    hmcfg = config.home-manager.users.${vars.user};
    xdgConfigHome =
      if hmcfg.xdg.enable
      then hmcfg.xdg.configHome
      else "${hmcfg.home.homeDirectory}/.config";
  in
    lib.mkIf config.myopts.programs.gpg.enable {
      home-manager.users.${vars.user} = {
        programs.password-store.enable = true;

        programs.gpg = {
          enable = true;
          homedir = "${xdgConfigHome}/gnupg";
        };

        programs.git.signing = {
          key = "BF9AB14D3B994BB1";
          signByDefault = true;
        };
      };
    };
}
