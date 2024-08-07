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
        'elkowar/yuck.vim',
        ft = { 'yuck' },
    },
    {
        'ledger/vim-ledger',
        ft = "ledger"
    },
}
