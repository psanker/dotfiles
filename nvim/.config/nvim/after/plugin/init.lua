require("nvim-tree").setup()
require("bufferline").setup({
    options = {
        mode = "tabs",
        separator_style = "slant",
    },
})
require("lualine").setup({
    options = {
        theme = 'OceanicNext'
    }
})
require('leap').add_default_mappings()
require('todo-comments').setup()

vim.api.nvim_create_autocmd(
    {"BufRead", "BufNewFile"},
    { pattern = {"*.qmd"}, command = "set ft=rmd"}
)

