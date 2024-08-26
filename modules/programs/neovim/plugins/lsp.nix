{
  lsp = {
    enable = true;
    servers = {
      gopls.enable = true;
      lua-ls.enable = true;
      nil-ls.enable = true;
      ocamllsp.enable = true;
      rust-analyzer = {
        enable = true;
        installCargo = true;
        installRustc = true;
      };
      templ.enable = true;
    };
    postConfig = builtins.readFile ./lua/extra-ls-clients.lua;
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
  luasnip.enable = true;
  cmp_luasnip.enable = true;
  cmp-nvim-lsp.enable = true;
  cmp = {
    enable = true;
    settings = {
      snippet.expand = "luasnip";
      mapping = {
        "<C-p>" = "cmp.mapping.select_prev_item()";
        "<C-n>" = "cmp.mapping.select_next_item()";
        "<Tab>" = "cmp.mapping.select_next_item()";
        "<C-Space>" = "cmp.mapping.complete()";
        "<CR>" = "cmp.mapping.confirm()";
      };
      sources = [
        {name = "nvim_lsp";}
        {name = "luasnip";}
        {name = "path";}
        {name = "buffer";}
        {name = "nvim_lua";}
      ];
    };
  };
}
