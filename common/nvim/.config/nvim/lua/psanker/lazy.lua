local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
    spec = {
        { import = 'psanker.plugins' }
    },
    git = {
        url_format = "git@github.com:%s.git",
    },
})

-- Post Lazy weirdness (mainly just treesitter)
-- require('nvim-treesitter.config').setup({
--     auto_install = true,
--     sync_install = false,
--     ignore_install = {},
--     ensure_installed = {
--         'r', 'rust', 'markdown',
--         'markdown_inline', 'python',
--         'go', 'ocaml', 'gitcommit'
--     },
--     highlight = {
--         enable = true,
--         disable = { 'tsql' },
--     },
--     textobjects = {
--         move = {
--             enable = true,
--             set_jumps = true,

--             goto_next_start = {
--                 ["]p"] = "@parameter.inner",
--                 ["]m"] = "@function.outer",
--                 ["]]"] = "@class.outer",
--             },
--             goto_next_end = {
--                 ["]M"] = "@function.outer",
--                 ["]["] = "@class.outer",
--             },
--             goto_previous_start = {
--                 ["[p"] = "@parameter.inner",
--                 ["[m"] = "@function.outer",
--                 ["[["] = "@class.outer",
--             },
--             goto_previous_end = {
--                 ["[M"] = "@function.outer",
--                 ["[]"] = "@class.outer",
--             },
--         },
--         lsp_interop = {
--             enable = true,
--             border = 'none',
--             peek_definition_code = {
--                 ["<leader>df"] = "@function.outer",
--                 ["<leader>dF"] = "@class.outer",
--             },
--         },
--         select = {
--             enable = true,
--             lookahead = true,

--             keymaps = {
--                 ["af"] = "@function.outer",
--                 ["if"] = "@function.inner",

--                 ["ac"] = "@conditional.outer",
--                 ["ic"] = "@conditional.inner",

--                 ["aa"] = "@parameter.outer",
--                 ["ia"] = "@parameter.inner",

--                 ["av"] = "@variable.outer",
--                 ["iv"] = "@variable.inner",
--             },
--         },
--     },
-- })
