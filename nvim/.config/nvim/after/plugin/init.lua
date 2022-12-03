require("nvim-tree").setup()
require("lualine").setup({
    options = {
        theme = 'gruvbox_light'
    }
})
require('leap').add_default_mappings()
require('todo-comments').setup()
