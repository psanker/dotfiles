{
  vars,
  pkgs,
  unstable,
  ...
}: {
  config = {
    home-manager.users.${vars.user} = {
      programs = {
        bat.enable = true;
        fzf.enable = true;
        kitty.enable = true;
        lf = {
          enable = true;
        };
        ripgrep.enable = true;
        starship.enable = true;
        taskwarrior.enable = true;
      };
      home.packages = with pkgs; [
        unstable.eza
        stow
      ];
    };
  };
}
