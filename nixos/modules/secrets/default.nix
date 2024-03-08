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
        "taskwarrior/taskd/server" = {
          owner = config.users.users.${vars.user}.name;
        };
      };
    };
  };
}
