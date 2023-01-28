return {
    {
        'ThePrimeagen/harpoon',
        dependencies = {
            'nvim-telescope/telescope.nvim',
        },
        config = function()
            require('telescope').load_extension('harpoon')
        end,
        keys = {
            { '<Leader>hh', '<cmd> lua require("harpoon.ui").toggle_quick_menu()<CR>' },
            { '<Leader>ha', '<cmd> lua require("harpoon.mark").add_file()<CR>' },
            { '<Leader>hn', '<cmd> lua require("harpoon.ui").nav_next()<CR>' },
            { '<Leader>hp', '<cmd> lua require("harpoon.ui").nav_prev()<CR>' },

            { '<Leader>hq', '<cmd> lua require("harpoon.ui").nav_file(4)<CR>' },
            { '<Leader>hw', '<cmd> lua require("harpoon.ui").nav_file(3)<CR>' },
            { '<Leader>he', '<cmd> lua require("harpoon.ui").nav_file(2)<CR>' },
            { '<Leader>hr', '<cmd> lua require("harpoon.ui").nav_file(1)<CR>' },
        },
    }
}
