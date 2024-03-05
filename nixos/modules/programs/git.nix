{vars, ...}: {
  config = {
    programs.git = {
      enable = true;

      config = {
        init = {
          defaultBranch = "main";
        };

        user = {
          inherit (vars) name;
          inherit (vars) email;
        };
      };
    };
  };
}
