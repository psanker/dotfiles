{
  lsp = {
    enable = true;
    servers = {
      gopls.enable = true;
      lua-ls.enable = true;
      nil_ls.enable = true;
      rust-analyzer = {
        enable = true;
        installCargo = true;
        installRustc = true;
      };
    };
  };
  lspkind = {
    enable = true;
    cmp = {
      enable = true;
      menu = {
        nvim_lsp = "[LSP]";
        nvim_lua = "[api]";
        path = "[path]";
        luasnip = "[snip]";
        buffer = "[buf]";
      };
    };
  };
  lsp-lines.enable = true;
  luasnip.enable = true;
  cmp_luasnip.enable = true;
  cmp-nvim-lsp.enable = true;
  nvim-cmp = {
    enable = true;
    snippet.expand = "luasnip";
    sources = [
      {name = "nvim_lsp";}
      {name = "luasnip";}
      {name = "path";}
      {name = "buffer";}
      {name = "nvim_lua";}
    ];
  };
}
