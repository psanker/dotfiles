return {
    {
        'jalvesaq/Nvim-R',
        ft = { 'r', 'rmd' },
    },
    {
        "iamcco/markdown-preview.nvim",
        build = function() vim.fn["mkdp#util#install"]() end,
        ft = 'markdown',
    },
    {
        'lukas-reineke/headlines.nvim',
        config = function(_)
            require('headlines').setup({
                markdown = {
                    headline_highlights = false,
                },
            })
        end,
        ft = { 'org' },
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
}
