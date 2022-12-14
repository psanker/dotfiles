require('nvim-treesitter.configs').setup({
    ensure_installed = { 'r', 'rust', 'python', 'go' },
    highlight = {
        enable = true
    },
    textobjects = {
        move = {
            enable = true,
            set_jumps = true,

            goto_next_start = {
                ["]p"] = "@parameter.inner",
                ["]m"] = "@function.outer",
                ["]]"] = "@class.outer",
            },
            goto_next_end = {
                ["]M"] = "@function.outer",
                ["]["] = "@class.outer",
            },
            goto_previous_start = {
                ["[p"] = "@parameter.inner",
                ["[m"] = "@function.outer",
                ["[["] = "@class.outer",
            },
            goto_previous_end = {
                ["[M"] = "@function.outer",
                ["[]"] = "@class.outer",
            },
        },
        lsp_interop = {
            enable = true,
            border = 'none',
            peek_definition_code = {
                ["<leader>df"] = "@function.outer",
                ["<leader>dF"] = "@class.outer",
            },
        },
        select = {
            enable = true,
            lookahead = true,

            keymaps = {
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",

                ["ac"] = "@conditional.outer",
                ["ic"] = "@conditional.inner",

                ["aa"] = "@parameter.outer",
                ["ia"] = "@parameter.inner",

                ["av"] = "@variable.outer",
                ["iv"] = "@variable.inner",
            },
        },
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
lsp.configure('cssls', {
    on_attach = function(client, bufnr)
        navic.attach(client, bufnr)
    end
})
lsp.configure('emmet_ls', {})

lsp.setup()

-- Trying rust-tools to get inlay-hints?
require('rust-tools').setup({
    tools = {
        inlay_hints = {
            auto = true
        }
    }
})

require('neorg').setup({
    load = {
        ['core.defaults'] = {},
        ['core.norg.completion'] = {
            config = {
                engine = 'nvim-cmp'
            },
        },
    }
})
