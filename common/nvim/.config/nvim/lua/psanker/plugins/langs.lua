return {
    {
        'jalvesaq/Nvim-R',
        ft = { 'r', 'rmd' },
        -- Something in the newest version of Nvim-R may be broken?
        commit = "97601b006d8c572fd9c3cf33e2e8d20b6e5f81e8",
        lazy = false,
    },
    {
        "iamcco/markdown-preview.nvim",
        build = function() vim.fn["mkdp#util#install"]() end,
        ft = 'markdown',
    },
    {
        'quarto-dev/quarto-nvim',
        dependencies = {
            'jmbuhr/otter.nvim',
            'neovim/nvim-lspconfig'
        },
        config = function()
            require('quarto').setup({
                lspFeatures = {
                    enabled = true,
                    languages = { 'r', 'python', 'julia' },
                    diagnostics = {
                        enabled = true,
                        triggers = { "BufWrite" }
                    },
                    completion = {
                        enabled = true
                    }
                }
            })
        end,
        ft = { 'quarto' },
    },
    {
        'elkowar/yuck.vim',
        ft = { 'yuck' },
    },
    {
        'Fymyte/tree-sitter-rasi',
        ft = "rasi"
    },
    {
        'ledger/vim-ledger',
        ft = "ledger"
    },
    {
        "nvim-neorg/neorg",
        build = ":Neorg sync-parsers",
        ft = "norg",
        dependencies = {
            { 'nvim-neorg/neorg-telescope' },
        },
        config = function()
            require('neorg').setup({
                load = {
                    ['core.defaults'] = {},
                    ['core.concealer'] = {},
                    ['core.dirman'] = {
                        config = {
                            workspaces = {
                                pkm = '~/personal/pkm',
                            },
                        },
                    },
                    ['core.integrations.telescope'] = {},
                }
            })
        end,
    },
}
