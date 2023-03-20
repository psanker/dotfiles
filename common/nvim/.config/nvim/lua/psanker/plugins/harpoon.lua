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
            { '<Leader>hh', '<cmd> lua require("harpoon.ui").toggle_quick_menu()<CR>', desc = '[h]arpoon: Toggle [h]arpoon menu' },
            { '<Leader>ha', '<cmd> lua require("harpoon.mark").add_file()<CR>', desc = '[h]arpoon: [a]dd file' },

            { '<Leader>hq', '<cmd> lua require("harpoon.ui").nav_file(4)<CR>', desc = '[h]arpoon: go to 4th file (q)' },
            { '<Leader>hw', '<cmd> lua require("harpoon.ui").nav_file(3)<CR>', desc = '[h]arpoon: go to 3rd file (w)' },
            { '<Leader>he', '<cmd> lua require("harpoon.ui").nav_file(2)<CR>', desc = '[h]arpoon: go to 2nd file (e)' },
            { '<Leader>hr', '<cmd> lua require("harpoon.ui").nav_file(1)<CR>', desc = '[h]arpoon: go to 1st file (r)' },
        },
    }
}
