local remap = require("psanker.keymap")
local nnoremap = remap.nnoremap
local inoremap = remap.nnoremap
local xnoremap = remap.nnoremap

require('orgmode').setup_ts_grammar()

require('nvim-treesitter.configs').setup({
    ensure_installed = { 'r', 'rust', 'python', 'go', 'org' },
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = { 'org' },
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
    ['<C-Space>'] = cmp.mapping.complete(),
})

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
    mapping = cmp_mappings,
    sources = {
        { name = 'path' },
        { name = 'orgmode' },
        { name = 'nvim_lsp', keyword_length = 3 },
        { name = 'buffer', keyword_length = 3 },
        { name = 'luasnip', keyword_length = 2 },
    },
})

local function bind_lsp_keymaps(client, bufnr)
    local opts = { buffer = bufnr }

    nnoremap('<Leader>F', function() vim.lsp.buf.format({ async = true }) end, opts)
    nnoremap('K', function() vim.lsp.buf.hover() end,
        { buffer = bufnr, desc = 'Display hover information of symbol under cursor' })
    nnoremap('gd', function() vim.lsp.buf.definition() end,
        { buffer = bufnr, desc = 'Go to definition of symbol under cursor' }) -- Jump to the definition
    nnoremap('gD', function() vim.lsp.buf.declaration() end,
        { buffer = bufnr, desc = 'Go to declaration of symbol under cursor' }) -- Jump to the declaration
    nnoremap('gi', function() vim.lsp.buf.implementation() end,
        { buffer = bufnr, desc = 'List all implementations of symbol under cursor' }) -- Lists all implementations of symbol
    nnoremap('go', function() vim.lsp.buf.type_definition() end,
        { buffer = bufnr, desc = 'Go to type definition of symbol under cursor' }) -- Jump to def of symbol
    nnoremap('gr', function() vim.lsp.buf.references() end,
        { buffer = bufnr, desc = 'List all references of symbol under cursor' }) -- List all references
    nnoremap('<C-h>', function() vim.lsp.signature_help() end,
        { buffer = bufnr, desc = 'Display signature of symbol under cursor' }) -- Displays function signature
    inoremap('<C-h>', function() vim.lsp.buf.signature_help() end,
        { buffer = bufnr, desc = 'Display signature of symbol under cursor' }) -- Displays function signature
    nnoremap('<Leader>r', function() vim.lsp.buf.rename() end, { buffer = bufnr, desc = 'Rename symbol under cursor' }) -- Renames all references of symbol
    nnoremap('<Leader>q', function() vim.lsp.buf.code_action() end, { buffer = bufnr, desc = 'Perform a code action' }) -- Selects a code action
    xnoremap('<Leader>q', function() vim.lsp.buf.range_code_action() end,
        { buffer = bufnr, desc = 'Perform a code action' }) -- "" for a range
end

lsp.on_attach(function(client, bufnr)
    bind_lsp_keymaps(client, bufnr)
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

require("zk").setup({
    -- can be "telescope", "fzf" or "select" (`vim.ui.select`)
    -- it's recommended to use "telescope" or "fzf"
    picker = "telescope",

    lsp = {
        -- `config` is passed to `vim.lsp.start_client(config)`
        config = {
            cmd = { "zk", "lsp" },
            name = "zk",
            -- on_attach = ...
            on_attach = bind_lsp_keymaps,
            -- etc, see `:h vim.lsp.start_client()`
        },

        -- automatically attach buffers in a zk notebook that match the given filetypes
        auto_attach = {
            enabled = true,
            filetypes = { "markdown" },
        },
    },
})
