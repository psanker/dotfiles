{lib, ...}:
with lib; {
  options = {
    wlwm.enable = mkOption {
      type = types.bool;
      default = false;
    };
  };
}
