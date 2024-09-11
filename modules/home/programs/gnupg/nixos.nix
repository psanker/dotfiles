{
  config,
  vars,
  ...
}: {
  config = let
    hmcfg = config.home-manager.users.${vars.user};
    sopsSecrets = config.sops.secrets;
  in {
    systemd.user.services.gpgimporter = {
      script = ''
        cat ${sopsSecrets."gpg/keyring".path} | base64 -d | ${hmcfg.programs.gpg.package}/bin/gpg --import
      '';
      serviceConfig = {
        Type = "oneshot";
      };
    };
  };
}
