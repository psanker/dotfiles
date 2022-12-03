local lspz = require('lsp-zero')

lspz.preset('recommended')
lspz.setup()

local cmp = require('cmp')
cmp.setup({
    -- Enable LSP snippets
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end,
    },
    mapping = {
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        -- Add tab support
        ['<S-Tab>'] = cmp.mapping.select_prev_item(),
        ['<Tab>'] = cmp.mapping.select_next_item(),
        ['<C-S-f>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
        })
    },
    -- Installed sources:
    sources = {
        { name = 'path' }, -- file paths
        { name = 'nvim_lsp', keyword_length = 3 }, -- from language server
        { name = 'nvim_lsp_signature_help' }, -- display function signatures with current parameter emphasized
        { name = 'nvim_lua', keyword_length = 2 }, -- complete neovim's Lua runtime API such vim.lsp.*
        { name = 'buffer', keyword_length = 2 }, -- source current buffer
        { name = 'vsnip', keyword_length = 2 }, -- nvim-cmp source for vim-vsnip
        { name = 'calc' }, -- source for math calculation
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
})

require('nvim-treesitter.configs').setup({
    ensure_installed = { 'r', 'rust', 'python', 'go' },
    highlight = {
        enable = true
    }
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()

local lsp_defaults = {
    flags = {
        debounce_text_changes = 150,
    },
    capabilities = capabilities,
    on_attach = function(_, _)
        vim.api.nvim_exec_autocmds('User', { pattern = 'LspAttached' })
    end
}

local lspconfig = require('lspconfig')
local navic = require('nvim-navic')

lspconfig.util.default_config = vim.tbl_deep_extend(
    'force',
    lspconfig.util.default_config,
    lsp_defaults
)

lspconfig.astro.setup({})
lspconfig.r_language_server.setup({
    on_attach = function(client, bufnr)
        navic.attach(client, bufnr)
    end,
    capabilities = capabilities,
})
lspconfig.sumneko_lua.setup({
    on_attach = function(client, bufnr)
        navic.attach(client, bufnr)
    end,
    capabilities = capabilities,
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
lspconfig.gopls.setup({
    on_attach = function(client, bufnr)
        navic.attach(client, bufnr)
    end,
    capabilities = capabilities,
})
lspconfig.taplo.setup({
    on_attach = function(client, bufnr)
        navic.attach(client, bufnr)
    end,
    capabilities = capabilities,
})
lspconfig.ltex.setup({
    capabilities = capabilities,
})
lspconfig.rust_analyzer.setup({
    cmd = { "rustup", "run", "nightly", "rust-analyzer" },
    on_attach = function(client, bufnr)
        navic.attach(client, bufnr)
    end,
    settings = {
        rust = {
            unstable_features = true,
            build_on_save = false,
            all_features = true,
        }
    }
})
