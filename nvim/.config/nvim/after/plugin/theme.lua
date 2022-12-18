local set = vim.opt
local g = vim.g

g.my_colorscheme = 'nightfox'

require('catppuccin').setup({
    flavour = 'mocha'
})

function DrawTheme()
  vim.cmd("colorscheme " .. g.my_colorscheme)
  set.background = 'dark'
end

DrawTheme()
