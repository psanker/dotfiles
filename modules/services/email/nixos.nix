{
  config,
  vars,
  ...
}: {
  config = let
    hmcfg = config.home-manager.users.${vars.user};
    xdgBinHome = "${hmcfg.home.homeDirectory}/.local/bin";
    accountRewriterPath = "${xdgBinHome}/email-account-rewrite.sh";
  in {
    systemd.user.services.email-account-rewrite = {
      script = ''
        ${accountRewriterPath}
      '';
      description = "Add personal email references";

      serviceConfig = {
        Type = "oneshot";
      };
    };
  };
}
