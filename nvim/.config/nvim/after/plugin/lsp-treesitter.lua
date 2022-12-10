require('nvim-treesitter.configs').setup({
    ensure_installed = { 'r', 'rust', 'python', 'go' },
    highlight = {
        enable = true
    },
})

local lsp = require('lsp-zero')
local navic = require('nvim-navic')

lsp.set_preferences({
    suggest_lsp_servers = true,
    setup_servers_on_start = true,
    set_lsp_keymaps = true,
    configure_diagnostics = true,
    cmp_capabilities = true,
    manage_nvim_cmp = true,
    call_servers = 'local',
    sign_icons = {}
})

lsp.configure('r_language_server', {
    on_attach = function(client, bufnr)
        navic.attach(client, bufnr)
    end
})

lsp.configure('sumneko_lua', {
    on_attach = function(client, bufnr)
        navic.attach(client, bufnr)
    end,
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { 'vim' },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
        },
    },
})
lsp.configure('gopls', {
    on_attach = function(client, bufnr)
        navic.attach(client, bufnr)
    end,
})
lsp.configure('taplo', {
    on_attach = function(client, bufnr)
        navic.attach(client, bufnr)
    end,
})
lsp.configure('rust_analyzer', {
    cmd = { "rustup", "run", "nightly", "rust-analyzer" },
    on_attach = function(client, bufnr)
        navic.attach(client, bufnr)
    end,
    settings = {
        ["rust-analyzer"] = {
            unstable_features = true,
            build_on_save = false,
            all_features = true,
            diagnostics = {
                experimental = true,
            },
        }
    }
})

lsp.setup()

-- Trying rust-tools to get inlay-hints?
require('rust-tools').setup({
    tools = {
        inlay_hints = {
            auto = true
        }
    }
})
