{
  noice = {
    enable = true;
    cmdline = {
      view = "cmdline";
      format = {
        search_down.view = "cmdline";
        search_up.view = "cmdline";
      };
    };
    lsp = {
      override = {
        "vim.lsp.util.convert_input_to_markdown_lines" = true;
        "vim.lsp.util.stylize_markdown" = true;
        "cmp.entry.get_documentation" = true;
      };
      hover.enabled = false;
      signature.enabled = false;
    };
    notify.view = "mini";
    presets = {
      bottom_search = true;
      command_palette = false;
      long_message_to_split = true;
      inc_rename = false;
      lsp_doc_border = false;
    };
  };
}
