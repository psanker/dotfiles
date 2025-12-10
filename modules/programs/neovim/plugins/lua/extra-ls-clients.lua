local lsp = vim.lsp.config

-- Attach & capabilities are defined in 
-- nixvim/plugins/lsp/default.nix

for key, _ in ipairs(lsp) do
    lsp[key].setup({
        on_attach = __lspOnAttach,
        capabilities = __lspCapabilities()
    })
end
