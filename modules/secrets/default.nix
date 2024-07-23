{
  config,
  vars,
  pkgs,
  ...
}: {
  config = let
    sopsCfg = {
      sops = let
        userCfg = config.users.users.${vars.user};
        usingMacos = config.myopts.platform == "darwin";
        homePrefix =
          if usingMacos
          then "/Users"
          else "/home";
      in {
        defaultSopsFile = ../../secrets/secrets.yaml;
        defaultSopsFormat = "yaml";

        age.keyFile = "${homePrefix}/${vars.user}/.config/sops/age/keys.txt";

        secrets = {
          "gpg/keyring" = {
            owner = userCfg.name;
          };

          "taskwarrior/taskd/server" = {
            owner = userCfg.name;
          };

          "taskwarrior/taskd/credentials" = {
            owner = userCfg.name;
          };

          "taskwarrior/taskd/key/filename" = {
            owner = userCfg.name;
          };

          "taskwarrior/taskd/key/content" = {
            owner = userCfg.name;
          };

          "taskwarrior/taskd/cacert/filename" = {
            owner = userCfg.name;
          };

          "taskwarrior/taskd/cacert/content" = {
            owner = userCfg.name;
          };

          "taskwarrior/taskd/cert/filename" = {
            owner = userCfg.name;
          };

          "taskwarrior/taskd/cert/content" = {
            owner = userCfg.name;
          };
        };
      };
    };
  in
    if pkgs.stdenv.isDarwin
    then {
      home-manager.users.${vars.user} = sopsCfg;
    }
    else sopsCfg;
}
