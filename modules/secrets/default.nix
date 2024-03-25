{
  config,
  inputs,
  vars,
  ...
}: {
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  config = {
    sops = {
      defaultSopsFile = ../../secrets/secrets.yaml;
      defaultSopsFormat = "yaml";

      age.keyFile = "/home/${vars.user}/.config/sops/age/keys.txt";

      secrets = {
        "gpg/keyring" = {
          owner = config.users.users.${vars.user}.name;
        };

        "taskwarrior/taskd/server" = {
          owner = config.users.users.${vars.user}.name;
        };

        "taskwarrior/taskd/credentials" = {
          owner = config.users.users.${vars.user}.name;
        };

        "taskwarrior/taskd/key/filename" = {
          owner = config.users.users.${vars.user}.name;
        };

        "taskwarrior/taskd/key/content" = {
          owner = config.users.users.${vars.user}.name;
        };

        "taskwarrior/taskd/cacert/filename" = {
          owner = config.users.users.${vars.user}.name;
        };

        "taskwarrior/taskd/cacert/content" = {
          owner = config.users.users.${vars.user}.name;
        };

        "taskwarrior/taskd/cert/filename" = {
          owner = config.users.users.${vars.user}.name;
        };

        "taskwarrior/taskd/cert/content" = {
          owner = config.users.users.${vars.user}.name;
        };
      };
    };
  };
}
