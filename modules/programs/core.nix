{
  vars,
  pkgs,
  unstable,
  ...
}: {
  config = {
    home-manager.users.${vars.user} = {
      xdg.configFile."lf/icons".source = ./icons;
      programs = {
        bat.enable = true;
        fzf.enable = true;
        kitty.enable = true;
        lf = {
          enable = true;
          settings = {
            preview = true;
            hidden = true;
            drawbox = true;
            icons = true;
            ignorecase = true;
          };
          extraConfig = let
            previewer = pkgs.writeShellScriptBin "pv.sh" ''
              file=$1
              w=$2
              h=$3
              x=$4
              y=$5

              if [[ "$( ${pkgs.file}/bin/file -Lb --mime-type "$file")" =~ ^image ]]; then
                  ${pkgs.kitty}/bin/kitty +kitten icat --silent --stdin no --transfer-mode file --place "''${w}x''${h}@''${x}x''${y}" "$file" < /dev/null > /dev/tty
                  exit 1
              fi

              ${pkgs.pistol}/bin/pistol "$file"
            '';
            cleaner = pkgs.writeShellScriptBin "clean.sh" ''
              ${pkgs.kitty}/bin/kitty +kitten icat --clear --stdin no --silent --transfer-mode file < /dev/null > /dev/tty
            '';
          in ''
            set cleaner ${cleaner}/bin/clean.sh
            set previewer ${previewer}/bin/pv.sh

            cmd trash %set -f; ${pkgs.trashy}/bin/trash $fx 

            map n

            map <esc> clear
            map D trash
            map nd :push %mkdir<space>
            map nf :push %touch<space>

            map gd cd ~/Downloads
            map gD cd ~/Documents
            map gp cd ~/personal
            map gP cd ~/Pictures
            map gw cd ~/workspace
          '';
        };
        ripgrep.enable = true;
        starship.enable = true;
      };
      home.packages = with pkgs; [
        unstable.discord
        unstable.eza
        stow
        trashy
        zk
      ];
    };
  };
}
