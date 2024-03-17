[
  {
    key = "<Leader>hh";
    action = "<cmd>lua require(\"harpoon\").ui:toggle_quick_menu(require(\"harpoon\"):list())<CR>";
    options.desc = "[h]arpoon: Toggle [h]arpoon menu";
  }

  {
    key = "<Leader>ha";
    action = "<cmd>lua require(\"harpoon\"):list():append()<CR>";
    options.desc = "[h]arpoon: [a]dd file";
  }

  {
    key = "<Leader>hq";
    action = "<cmd>lua require(\"harpoon\"):list():select(4)<CR>";
    options.desc = "[h]arpoon: go to 4th file (q)";
  }

  {
    key = "<Leader>hw";
    action = "<cmd>lua require(\"harpoon\"):list():select(3)<CR>";
    options.desc = "[h]arpoon: go to 3rd file (w)";
  }

  {
    key = "<Leader>he";
    action = "<cmd>lua require(\"harpoon\"):list():select(2)<CR>";
    options.desc = "[h]arpoon: go to 2nd file (e)";
  }

  {
    key = "<Leader>hr";
    action = "<cmd>lua require(\"harpoon\"):list():select(1)<CR>";
    options.desc = "[h]arpoon: go to 1st file (r)";
  }
]
