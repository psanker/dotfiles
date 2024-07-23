{config, inputs, lib, ...}:
{
  imports = [
    inputs.home-manager.darwinModules.home-manager
    ./home.nix
    ./modules
  ];

  config = let
    gpgImporterScriptMacosLocation = "${config.home.homeDirectory}/.local/bin/gpgimporter.sh";
  in {
    launchd = lib.mkIf config.myopts.programs.git.enable {
      agents."com.patrickanker.nix.gpgimporter" = {
        enable = true;
        config = {
          LaunchOnlyOnce = true;
          RunAtLoad = true;
          Program = gpgImporterScriptMacosLocation;
        };
      };
    };
  };
}
