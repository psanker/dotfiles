return {
    {
        'psanker/zk-nvim',
        branch = 'better-linking',
        dependencies = {
            'nvim-telescope/telescope.nvim',
        },
        config = function()
            local bind_lsp_keymaps = require('psanker.edit.lsp').bind_lsp_keymaps

            require('zk').setup({
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
                }
            })

            require('psanker.edit.pkm').setup()
            require('psanker.edit.pkm').register_commands()

            require('telescope').load_extension('zk')
        end,
        keys = { '<Leader>ft', '<Leader>fn', '<Leader>nm', '<Leader>nn', '<Leader>nj' }
    },
    {
        'andymass/vim-matchup',
        event = { 'BufReadPre', 'BufNewFile' }
    },
    {
        'ggandor/leap.nvim',
        event = 'VeryLazy',
        config = function(_)
            require('leap').add_default_mappings()
        end,
    },
    {
        'junegunn/vim-easy-align',
        event = { 'BufReadPost', 'BufNewFile' },
    },
}
