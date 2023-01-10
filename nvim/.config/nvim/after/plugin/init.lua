local g = vim.g

require('leap').add_default_mappings()
require('nvim-tree').setup()

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

g.mkdp_port = 8800
g.mkdp_page_title = '${name} - md.nvim'
g.mkdp_auto_start = 1
