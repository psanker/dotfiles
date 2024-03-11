{
  config,
  pkgs,
  lib,
  vars,
  ...
}: {
  config = let
    hmcfg = config.home-manager.users.${vars.user};
    usingLinux = config.myopts.platform.linux;
    xdgConfigHome =
      if hmcfg.xdg.enable
      then hmcfg.xdg.configHome
      else "${hmcfg.home.homeDirectory}/.config";
    xdgCacheHome =
      if hmcfg.xdg.enable
      then hmcfg.xdg.cacheHome
      else "${hmcfg.home.homeDirectory}/.cache";
    xdgDataHome =
      if hmcfg.xdg.enable
      then hmcfg.xdg.dataHome
      else "${hmcfg.home.homeDirectory}/.local/share";
  in {
    home-manager.users.${vars.user} = {
      accounts.email = {
        maildirBasePath = "${xdgDataHome}/mail";
        accounts = {
          nyu = let
            email = "psa251@nyu.edu";
          in {
            primary = true;

            address = email;
            userName = email;
            realName = "Patrick Anker";
            aliases = ["psanker@nyu.edu"];

            passwordCommand = "${hmcfg.programs.password-store.package}/bin/pass ${email}";

            imap = {
              host = "imap.gmail.com";
              port = 993;
              tls.enable = true;
            };

            smtp = {
              host = "smtp.gmail.com";
              port = 465;
              tls.enable = true;
            };

            mbsync = {
              enable = false;
              extraConfig.account = {
                AuthMechs = "LOGIN";
              };
            };

            aerc = {
              enable = true;
              extraAccounts = {
                default = "INBOX";
                archive = "Archive";
                from = "Patrick Anker <psanker@nyu.edu>";
              };
            };

            notmuch.enable = false;
          };
        };
      };

      programs = {
        aerc = {
          enable = true;

          extraConfig = {
            general.unsafe-accounts-conf = true;

            filters = {
              "text/plain" = "${pkgs.aerc}/libexec/aerc/filters/colorize";
              "text/html" = "${pkgs.w3m}/bin/w3m -T text/html";
            };

            openers = {
              "text/plain" = "${config.programs.nixvim.package}/bin/nvim";
              "text/html" = "${pkgs.w3m}/bin/w3m -T text/html";
            };
          };

          stylesets = {
            default = {
              "msglist_read.fg" = "grey";
              "msglist_unread.bold" = "true";

              "msglist_result.fg" = "yellow";

              "msglist_marked.bg" = "blue";

              "msglist_flagged.bg" = "red";
              "msglist_flagged.fg" = "white";
            };
          };
        };

        notmuch.enable = false;
        mbsync.enable = false;
      };
    };
  };
}
