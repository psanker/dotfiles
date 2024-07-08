return {
    {
        'ThePrimeagen/harpoon',
        branch = 'harpoon2',
        dependencies = {
            'nvim-lua/plenary.nvim'
        },
        config = function()
            require('harpoon').setup()
        end,
        keys = {
            { '<Leader>hh', '<cmd>lua require("harpoon").ui:toggle_quick_menu(require("harpoon"):list())<CR>', desc = '[h]arpoon: Toggle [h]arpoon menu' },
            { '<Leader>ha', '<cmd>lua require("harpoon"):list():add()<CR>', desc = '[h]arpoon: [a]dd file' },

            { '<Leader>hq', '<cmd>lua require("harpoon"):list():select(4)<CR>', desc = '[h]arpoon: go to 4th file (q)' },
            { '<Leader>hw', '<cmd>lua require("harpoon"):list():select(3)<CR>', desc = '[h]arpoon: go to 3rd file (w)' },
            { '<Leader>he', '<cmd>lua require("harpoon"):list():select(2)<CR>', desc = '[h]arpoon: go to 2nd file (e)' },
            { '<Leader>hr', '<cmd>lua require("harpoon"):list():select(1)<CR>', desc = '[h]arpoon: go to 1st file (r)' },
        },
    }
}
