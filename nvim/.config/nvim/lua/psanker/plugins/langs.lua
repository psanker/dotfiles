return {
    {
        'jalvesaq/Nvim-R',
        ft = { 'r', 'rmd', 'quarto' },
    },
    {
        "iamcco/markdown-preview.nvim",
        build = function() vim.fn["mkdp#util#install"]() end,
        ft = 'markdown',
    },
    {
        'simrat39/rust-tools.nvim',
        ft = 'rust',
        config = function(_)
            require('rust-tools').setup({
                tools = {
                    inlay_hints = {
                        auto = true
                    }
                }
            })
        end,
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
}
