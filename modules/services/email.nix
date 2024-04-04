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
    nyuSignatureFile = "${xdgConfigHome}/aerc/signatures/nyu";
  in {
    home-manager.users.${vars.user} = {
      home.file.${nyuSignatureFile} = {
        text = ''
          -- 
          Patrick Anker | Data Manager
          NYU Global TIES for Children <https://globaltiesforchildren.nyu.edu/>
        '';
      };

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
                signature-file = nyuSignatureFile;
              };
              extraConfig = {
                ui = {
                  "reverse-thread-order" = true;
                };
              };
            };

            notmuch.enable = false;
          };
        };
      };

      programs = {
        abook.enable = true;
        aerc = {
          enable = true;

          extraBinds = {
            messages = {
              q = ":prompt 'Quit? [Y/n] ' quit<Enter>";

              j = ":next<Enter>";
              "<Down>" = ":next<Enter>";
              "<C-d>" = ":next 50%<Enter>";

              k = ":prev<Enter>";
              "<up>" = ":prev<Enter>";
              "<C-u>" = ":prev 50%<Enter>";

              gg = ":select 0<Enter>";
              G = ":select -1<Enter>";

              J = ":next-folder<Enter>";
              K = ":prev-folder<Enter>";
              H = ":collapse-folder<Enter>";
              L = ":expand-folder<Enter>";

              v = ":mark -t<Enter>";
              "<Space>" = ":mark -t<Enter>:next<Enter>";
              V = ":mark -v<Enter>";

              T = ":toggle-threads<Enter>";
              zc = ":fold<Enter>";
              zo = ":unfold<Enter>";

              F = ":flag -t<Enter>";

              "<Enter>" = ":view<Enter>";
              d = ":prompt 'Really delete this message?' 'delete-message'<Enter>";
              D = ":delete<Enter>";
              a = ":archive flat<Enter>";
              A = ":unmark -a<Enter>:mark -T<Enter>:archive flat<Enter>";

              C = ":compose<Enter>";
              m = ":compose<Enter>"; # Mutt compat

              rr = ":reply -a<Enter>";
              rq = ":reply -aq<Enter>";
              Rr = ":reply<Enter>";
              Rq = ":reply -q<Enter>";

              c = ":cf<space>";
              "$" = ":term<space>";
              "!" = ":term<space>";
              "|" = ":pipe<space>";

              "/" = ":search<space>";
              "\\" = ":filter<space>";
              "n" = ":next-result<Enter>";
              "N" = ":prev-result<Enter>";
              "<Esc>" = ":clear<Enter>";

              "<C-w>s" = ":split<Enter>";
              "<C-w>v" = ":vsplit<Enter>";
            };

            "messages:folder=Drafts" = {
              "<Enter>" = ":recall<Enter>";
            };

            view = {
              "/" = ":toggle-key-passthrough<Enter>/";
              q = ":close<Enter>";
              O = ":open<Enter>";
              o = ":open<Enter>";
              S = ":save<space>";
              "|" = ":pipe<space>";
              D = ":delete<Enter>";
              A = ":archive flat<Enter>";

              "<C-l>" = ":open-link <space>";

              f = ":forward<Enter>";
              rr = ":reply -a<Enter>";
              rq = ":reply -aq<Enter>";
              Rr = ":reply<Enter>";
              Rq = ":reply -q<Enter>";

              H = ":toggle-headers<Enter>";
              "<C-k>" = ":prev-part<Enter>";
              "<C-Up>" = ":prev-part<Enter>";
              "<C-j>" = ":next-part<Enter>";
              "<C-Down>" = ":next-part<Enter>";
              J = ":next<Enter>";
              "<C-Right>" = ":next<Enter>";
              K = ":prev<Enter>";
              "<C-Left>" = ":prev<Enter>";
            };

            "view::passthrough" = {
              "$noinherit" = true;
              "$ex" = "<C-x>";
              "<Esc>" = ":toggle-key-passthrough<Enter>";
            };

            compose = {
              "$noinherit" = true;
              "$ex" = "<C-x>";
              "<C-k>" = ":prev-field<Enter>";
              "<C-j>" = ":next-field<Enter>";
              "<A-p>" = ":switch-account -p<Enter>";
              "<A-n>" = ":switch-account -n<Enter>";
              "<tab>" = ":next-field<Enter>";
              "<backtab>" = ":prev-field<Enter>";
              "<C-p>" = ":prev-tab<Enter>";
              "<C-n>" = ":next-tab<Enter>";
            };

            "compose::editor" = {
              "$noinherit" = true;
              "$ex" = "<C-x>";
              "<C-k>" = ":prev-field<Enter>";
              "<C-j>" = ":next-field<Enter>";
              "<C-p>" = ":prev-tab<Enter>";
              "<C-n>" = ":next-tab<Enter>";
            };

            "compose::review" = {
              y = ":send<Enter>";
              n = ":abort<Enter>";
              v = ":preview<Enter>";
              p = ":postpone<Enter>";
              q = ":choose -o d discard abort -o p postpone postpone<Enter>";
              e = ":edit<Enter>";
              a = ":attach<space>";
              d = ":detach<space>";
            };

            terminal = {
              "$noinherit" = true;
              "$ex" = "<C-x>";

              "<C-p>" = ":prev-tab<Enter>";
              "<C-n>" = ":next-tab<Enter>";
              "<C-PgUp>" = ":prev-tab<Enter>";
              "<C-PgDn>" = ":next-tab<Enter>";
            };
          };

          extraConfig = {
            general.unsafe-accounts-conf = true;

            filters = {
              "text/plain" = "${pkgs.aerc}/libexec/aerc/filters/colorize";
              "text/html" = "${pkgs.aerc}/libexec/aerc/filters/html | ${pkgs.aerc}/libexec/aerc/filters/colorize";
            };

            openers = {
              "text/plain" = "${config.programs.nixvim.package}/bin/nvim";
              "text/html" = "${pkgs.w3m}/bin/w3m -T text/html";
              "application/pdf" = "${hmcfg.programs.sioyek.package}/bin/sioyek";
              "image/*" = "${pkgs.feh}/bin/feh";
            };

            compose = {
              "address-book-cmd" = "${pkgs.abook}/bin/abook --mutt-query \"%s\"";
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

              "tab.reverse" = false;
              "tab.bg" = "black";
              "tab.fg" = "magenta";

              "dirlist_default.fg" = "grey";
            };
          };
        };

        notmuch.enable = false;
        mbsync.enable = false;
      };
    };
  };
}
