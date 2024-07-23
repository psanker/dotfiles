{config, inputs, lib, ...}:
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ./home.nix
    ./modules
    ./modules/media
    ./modules/rofi
  ];

  config = {
    myopts = {
      programs.rofi.enable = true;
    };

    systemd.user = {
      timers = {
        task-sync = lib.mkIf config.myopts.programs.taskwarrior.enable {
          Unit.Description = "Synchronize with WingTask";
          Install.WantedBy = ["timers.target"];
          Timer = {
            OnUnitActiveSec = "60s";
            OnBootSec = "60s";
          };
        };
      };

      services = let
        xdgBinHome = "${config.home.homeDirectory}/.local/bin";
      in {
        gpgimporter = lib.mkIf config.myopts.programs.git.enable {
          Unit.Description = "Import keys from keyring into gpg";
          Install.WantedBy = ["default.target"];
          Service = {
            ExecStart = "${xdgBinHome}/gpgimporter.sh";
            Type = "oneshot";
          };
        };

        taskrcwriter = lib.mkIf config.myopts.programs.taskwarrior.enable {
          Unit.Description = "Write the Taskwarrior config file with secrets";
          Install.WantedBy = ["default.target"];
          Service = {
            ExecStart = "${xdgBinHome}/taskrcwriter";
            Type = "oneshot";
          };
        };

        task-sync = lib.mkIf config.myopts.programs.taskwarrior.enable {
          Unit.Description = "Synchronize with WingTask";
          Install.WantedBy = ["default.target"];
          Service = {
            ExecStart = "${config.programs.taskwarrior.package}/bin/task sync";
            Type = "oneshot";
          };
        };
      };
    };
  };
}
