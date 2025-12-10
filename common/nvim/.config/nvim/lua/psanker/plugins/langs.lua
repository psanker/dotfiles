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
    {
        "quarto-dev/quarto-nvim",
        dependencies = {
            "jmbuhr/otter.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
    },
    {
        "nvim-neorg/neorg",
        lazy = false, -- Disable lazy loading 
        version = "*", -- Pin to latest stable release
        opts = {
            load = {
                ["core.defaults"] = {}, -- Load default modules
                ["core.concealer"] = {}, -- Handles visual rendering of markup
                ["core.dirman"] = { -- Manages workspaces
                  config = {
                    workspaces = {
                      notes = "~/Documents/dnd", -- D&D notes
                    },
                    default_workspace = "notes", -- Set "notes" as default
                  },
                },
                ["core.keybinds"] = {
                    config = {
                        default_keybinds = true, -- Use default keybindings
                        neorg_leader = ",", -- Set the leader key for Neorg commands
                    },
                },
            },
        },
    },
}
