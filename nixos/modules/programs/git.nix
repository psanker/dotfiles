{ pkgs, vars, ...}: {
  programs.git = {
    enable = true;

    config = {
      init = {
        defaultBranch = "main";
      };

      user = {
        name = "${vars.name}";
        email = "${vars.email}";
      };
    };
  };
}
