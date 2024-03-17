[
  {
    event = ["BufEnter" "BufWinEnter"];
    pattern = ["*.Rmd" "*.rmd" "*.md" "*.qmd"];
    group = "MyWriting";
    callback = {
      __raw = builtins.readFile ./writing.lua;
    };
  }
]
