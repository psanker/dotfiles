local remap = require("psanker.keymap")
local nnoremap = remap.nnoremap
local inoremap = remap.nnoremap
local xnoremap = remap.nnoremap

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

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-space>'] = cmp.mapping.complete(),
})

cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab>'] = nil

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

lsp.setup_nvim_cmp({
    mapping = cmp_mappings
})

lsp.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr }

    nnoremap('<Leader>fr', function() vim.lsp.buf.format({ async = true }) end, opts)
    nnoremap('K', function() vim.lsp.buf.hover() end, opts)
    nnoremap('gd', function() vim.lsp.buf.definition() end, opts) -- Jump to the definition
    nnoremap('gD', function() vim.lsp.buf.declaration() end, opts) -- Jump to the declaration
    nnoremap('gi', function() vim.lsp.buf.implementation() end, opts) -- Lists all implementations of symbol
    nnoremap('go', function() vim.lsp.buf.type_definition() end, opts) -- Jump to def of symbol
    nnoremap('gr', function() vim.lsp.buf.references() end, opts) -- List all references
    nnoremap('<C-h>', function() vim.lsp.buf.signature_help() end, opts) -- Displays function signature
    inoremap('<C-h>', function() vim.lsp.buf.signature_help() end, opts) -- Displays function signature
    nnoremap('<Leader>r', function() vim.lsp.buf.rename() end, opts) -- Renames all references of symbol
    nnoremap('<Leader>q', function() vim.lsp.buf.code_action() end, opts) -- Selects a code action
    xnoremap('<Leader>q', function() vim.lsp.buf.range_code_action() end, opts) -- "" for a range

    pcall(function() navic.attach(client, bufnr) end)
end)

lsp.configure('sumneko_lua', {
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
lsp.configure('rust_analyzer', {
    cmd = { "rustup", "run", "nightly", "rust-analyzer" },
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
