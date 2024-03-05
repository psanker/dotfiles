{
  telescope = {
    enable = true;
    defaults = {
      vimgrep_arguments = [
        "rg"
        "--color=never"
        "--no-heading"
        "--with-filename"
        "--line-number"
        "--column"
        "--smart-case"
        "--hidden"
        "--glob=!.git"
      ];
    };
    extraOptions = {
      pickers = {
        find_files = {
          find_command = [
            "rg"
            "--files"
            "--hidden"
            "--glob=!.git"
          ];
        };
      };
    };
  };
}
