require("nvim-tree").setup()
require("bufferline").setup({
    options = {
        mode = "buffers",
        separator_style = "slant",
    },
})
require("lualine").setup({
    options = {
        theme = 'OceanicNext'
    }
})
require('leap').add_default_mappings()

require('todo-comments').setup({
    search = {
        command = 'rg',
        args = {
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--glob=!{_site,renv}"
        },
    }
})

vim.api.nvim_create_autocmd(
    { "BufRead", "BufNewFile" },
    { pattern = { "*.qmd" }, command = "set ft=rmd" }
)
