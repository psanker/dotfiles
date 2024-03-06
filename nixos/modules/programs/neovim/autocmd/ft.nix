[
  {
    event = ["BufEnter" "BufWinEnter"];
    pattern = ["*.nix"];
    callback = {
      __raw = builtins.readFile ./ft/nix.lua;
    };
  }
]
