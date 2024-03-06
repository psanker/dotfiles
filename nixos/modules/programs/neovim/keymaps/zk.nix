[
  {
    key = "<Leader>nn";
    action = ":lua require('zk.commands').get('ZkNew')({ dir = \"notes\" })<CR>";
    options.desc = "[n]ew [n]ote";
  }

  {
    key = "<Leader>nj";
    action = ":lua require('zk.commands').get('ZkNew')({ dir = \"journal\", group = \"journal\" })<CR>";
    options.desc = "[n]ew [j]ournal entry";
  }

  {
    key = "<Leader>nm";
    action = ":lua require('zk.commands').get('ZkNew')({ dir = \"notes\", template = \"meeting.md\" })<CR>";
    options.desc = "[n]ew [m]eeting note";
  }

  {
    key = "<Leader>nn";
    action = ":lua require('zk.commands').get('ZkNewFromTitleSelection')({ dir = 'notes' })<CR>";
    options.desc = "[n]ew [n]ote; title from selected text";
    mode = "v";
  }

  {
    key = "<Leader>ni";
    action = ":lua require('zk.commands').get('ZkNewFromTitleSelection')({ dir = 'notes', edit = false })<CR>";
    options.desc = "New [n]ote [i]nsert link; title from selected text";
    mode = "v";
  }

  {
    key = "<Leader>fn";
    action = "<cmd>ZkNotes<CR>";
    options.desc = "[f]ind [n]ote";
  }

  {
    key = "<Leader>fn";
    action = ":'<,'>ZkMatch<CR>";
    options.desc = "[f]ind [n]ote based on selected text";
    mode = "v";
  }

  {
    key = "<Leader>ft";
    action = "<cmd>ZkTags<CR>";
    options.desc = "[f]ind [t]ag";
  }

  {
    key = "<Leader>lb";
    action = "<cmd>ZkBacklinks<CR>";
    options.desc = "[l]inking: show [b]acklinks";
  }

  {
    key = "<Leader>ll";
    action = "<cmd>ZkLinks<CR>";
    options.desc = "[l]inking: show [l]inks to file";
  }

  {
    key = "<Leader>li";
    action = "<cmd>ZkInsertLink<CR>";
    options.desc = "[l]inking: [i]nsert link at cursor";
  }

  {
    key = "<Leader>li";
    action = ":'<,'>ZkInsertLinkAtSelection<CR>";
    options.desc = "[l]inking: [i]nsert link around selected text";
    mode = "v";
  }

  {
    key = "<Leader>ls";
    action = ":lua require('zk.commands').get('ZkInsertLinkAtSelection')({ match = true })<CR>";
    options.desc = "[l]inking: insert link, [s]earching for selected text";
    mode = "v";
  }
]
