local wez = require('wezterm')

local cfg = {}

-- Window
cfg.enable_tab_bar = false
cfg.window_padding = {
    left = '2cell',
    right = '2cell',
    top = '1cell',
    bottom = '0cell',
}
cfg.window_background_opacity = 0.97
cfg.window_decorations = 'RESIZE'

-- Font
cfg.font = wez.font 'Hasklug Nerd Font'

-- Theme
cfg.color_scheme = 'rose-pine-moon'

return cfg
