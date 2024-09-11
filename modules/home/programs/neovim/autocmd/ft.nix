[
  {
    event = ["BufEnter" "BufWinEnter"];
    pattern = ["*.nix"];
    callback = {
      __raw = builtins.readFile ./ft/nix.lua;
    };
  }

  {
    event = ["BufEnter" "BufWinEnter"];
    pattern = ["*.r" "*.R"];
    callback = {
      __raw = builtins.readFile ./ft/r.lua;
    };
  }

  {
    event = ["BufEnter" "BufWinEnter"];
    pattern = ["*.rmd" "*.Rmd"];
    callback = {
      __raw = builtins.readFile ./ft/rmd.lua;
    };
  }
]
