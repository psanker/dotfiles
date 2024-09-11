{
  config,
  lib,
  vars,
  pkgs,
  ...
}: {
  options = {
    myopts.programs.hledger.enable = lib.mkEnableOption "Use hledger";
  };

  config.home-manager.users.${vars.user} = lib.mkIf config.myopts.programs.hledger.enable {
    home.packages = with pkgs; [
      hledger
      hledger-ui
    ];
  };
}
