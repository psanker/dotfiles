return {
    {
        'R-nvim/R.nvim',
        ft = { 'r', 'rmd' },
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
