[
  {
    key = "<Leader>gg";
    action = "<CMD>Git<CR>";
    options.desc = "Open fu[g]itive window";
  }

  {
    key = "<Leader>gp";
    action = "<CMD>Git pull --rebase<CR>";
    options.desc = "[g]it [p]ull (by rebase)";
  }

  {
    key = "<Leader>gP";
    action = "<CMD>Git push<CR>";
    options.desc = "[g]it [p]ush";
  }

  {
    key = "<Leader>gl";
    action = "<cmd>Gclog!<CR>";
    options.desc = "Load [g]it [l]og into quickfix";
  }

  {
    key = "<Leader>gl";
    action = ":'<,'>Gclog!<CR>";
    mode = "v";
    options.desc = "Load [g]it [l]og for current hunk into quickfix";
  }

  {
    key = "<Leader>gf";
    action = "<cmd>Git fetch<CR>";
    options.desc = "[g]it [f]etch";
  }

  {
    key = "<Leader>gdv";
    action = "<cmd>Gvdiffsplit!<CR>";
    options.desc = "[g]it: open 3-way [d]iff [v]ertical split";
  }

  {
    key = "<Leader>gdh";
    action = "<cmd>Gdiffsplit!<CR>";
    options.desc = "[g]it: open 3-way [d]iff [h]orizontal split";
  }
]
