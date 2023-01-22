local g = vim.g

g.my_colorscheme = 'rose-pine'

-- require('catppuccin').setup({
--     flavour = 'mocha'
-- })

-- require('tokyonight').setup({
--     style = 'night'
-- })

vim.cmd("colorscheme " .. g.my_colorscheme)

