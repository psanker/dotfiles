[
  {
    key = "<Leader>ff";
    action = "<CMD>Telescope find_files<CR>";
    options.desc = "[f]ind [f]ile";
  }

  {
    key = "<Leader>fw";
    action = "<CMD>Telescope grep_string<CR>";
    options.desc = "[f]ind [w]ord under cursor";
  }

  {
    key = "<Leader>fg";
    action = "<CMD>Telescope live_grep<CR>";
    options.desc = "[f]ind string using [g]rep";
  }

  {
    key = "<Leader>fk";
    action = "<CMD>Telescope keymaps<CR>";
    options.desc = "[f]ind [k]eymap";
  }

  {
    key = "<Leader>/";
    action = "<CMD>Telescope current_buffer_fuzzy_find<CR>";
    options.desc = "Fuzzy find in current buffer, like [/]";
  }

  {
    key = "<Leader>fh";
    action = "<CMD>Telescope help_tags<CR>";
    options.desc = "[f]ind in [h]elp";
  }

  {
    key = "<Leader>fs";
    action = "<CMD>Telescope lsp_document_symbols<CR>";
    options.desc = "[f]ind [s]ymbol in current document";
  }

  {
    key = "<Leader>fS";
    action = "<CMD>Telescope lsp_document_symbols<CR>";
    options.desc = "[f]ind [S]ymbol in current workspace";
  }
]
