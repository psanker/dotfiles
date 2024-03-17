local wez = require('wezterm')

local cfg = {}

-- From https://stackoverflow.com/questions/1340230/check-if-directory-exists-in-lua
--- Check if a file or directory exists in this path
local function exists(file)
    local ok, err, code = os.rename(file, file)
    if not ok then
        if code == 13 then
            -- Permission denied, but it exists
            return true
        end
    end
    return ok, err
end

--- Check if a directory exists in this path
local function isdir(path)
    -- "/" works on both Unix and Windows
    return exists(path .. "/")
end

-- Window
cfg.enable_tab_bar = false
cfg.window_padding = {
    left = '2cell',
    right = '2cell',
    top = '1cell',
    bottom = '0cell',
}
cfg.window_background_opacity = 0.97

-- Font
cfg.font = wez.font_with_fallback {
    'Hasklug Nerd Font Mono',
    'Hasklug Nerd Font',
    'SF Mono',
    'SF Pro',
    'JetBrains Mono',
}

-- Theme
cfg.color_scheme = 'rose-pine-moon'

-- Shell

local handle = io.popen 'which fish'
local fish_path = handle:read '*a'
fish_path = fish_path:gsub('[\n\r]', '')

-- Shell config
cfg.default_prog = { fish_path, '-l' }

-- Autoreload
cfg.automatically_reload_config = true

return cfg
