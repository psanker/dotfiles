require('mason').setup()
require('mason-lspconfig').setup({
    ensure_installed = { "sumneko_lua", "rust_analyzer", "r_language_server", "ltex" }
})