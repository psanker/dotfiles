local lsp = require('lspconfig')

-- Attach & capabilities are defined in 
-- nixvim/plugins/lsp/default.nix

lsp.r_language_server.setup({
    on_attach = __lspOnAttach,
    capabilities = __lspCapabilities()
})

lsp.ocamllsp.setup({
    on_attach = __lspOnAttach,
    capabilities = __lspCapabilities()
})
