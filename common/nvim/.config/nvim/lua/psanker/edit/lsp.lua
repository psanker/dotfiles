local remap = require("psanker.keymap")
local nnoremap = remap.nnoremap
local inoremap = remap.nnoremap
local xnoremap = remap.nnoremap

-- require('orgmode').setup_ts_grammar()
M = {}

function M.bind_lsp_keymaps(_, bufnr)
    local opts = { buffer = bufnr }

    nnoremap('<Leader>F', function() vim.lsp.buf.format({ async = true }) end, opts)
    nnoremap('K', vim.lsp.buf.hover, { buffer = bufnr, desc = 'Display hover information of symbol under cursor' })
    nnoremap('gd', function() vim.lsp.buf.definition() end,
        { buffer = bufnr, desc = 'Go to definition of symbol under cursor' })                                            -- Jump to the definition
    nnoremap('gD', function() vim.lsp.buf.declaration() end,
        { buffer = bufnr, desc = 'Go to declaration of symbol under cursor' })                                           -- Jump to the declaration
    nnoremap('gi', function() vim.lsp.buf.implementation() end,
        { buffer = bufnr, desc = 'List all implementations of symbol under cursor' })                                    -- Lists all implementations of symbol
    nnoremap('go', function() vim.lsp.buf.type_definition() end,
        { buffer = bufnr, desc = 'Go to type definition of symbol under cursor' })                                       -- Jump to def of symbol
    nnoremap('gr', function() vim.lsp.buf.references() end,
        { buffer = bufnr, desc = 'List all references of symbol under cursor' })                                         -- List all references
    nnoremap('<C-h>', function() vim.lsp.signature_help() end,
        { buffer = bufnr, desc = 'Display signature of symbol under cursor' })                                           -- Displays function signature
    inoremap('<C-h>', function() vim.lsp.buf.signature_help() end,
        { buffer = bufnr, desc = 'Display signature of symbol under cursor' })                                           -- Displays function signature
    nnoremap('<Leader>r', function() vim.lsp.buf.rename() end, { buffer = bufnr, desc = 'Rename symbol under cursor' })  -- Renames all references of symbol
    nnoremap('<Leader>ca', function() vim.lsp.buf.code_action() end, { buffer = bufnr, desc = 'Perform a code action' }) -- Selects a code action
    xnoremap('<Leader>ca', function() vim.lsp.buf.range_code_action() end,
        { buffer = bufnr, desc = 'Perform a code action' })                                                              -- "" for a range
end

function M.setup_lsp(lsp, navic)
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
            { name = 'buffer',   keyword_length = 3 },
            { name = 'luasnip',  keyword_length = 2 },
        },
    })

    lsp.on_attach(function(client, bufnr)
        M.bind_lsp_keymaps(client, bufnr)

        if client.server_capabilities.documentSymbolProvider then
            pcall(function() navic.attach(client, bufnr) end)
        end
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

    vim.diagnostic.config({
        virtual_text = true,
        float = false,
    })
end

return M
