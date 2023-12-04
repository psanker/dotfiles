local wez = require('wezterm')

local cfg = {}

-- From https://stackoverflow.com/questions/1340230/check-if-directory-exists-in-lua
--- Check if a file or directory exists in this path
function exists(file)
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
function isdir(path)
   -- "/" works on both Unix and Windows
   return exists(path.."/")
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
cfg.window_decorations = 'RESIZE'

-- Font
cfg.font = wez.font 'Hasklug Nerd Font'

-- Theme
cfg.color_scheme = 'rose-pine-moon'

-- Shell
local prefix = '/usr/local'

if isdir('/opt/homebrew') then
    prefix = '/opt/homebrew'
end

cfg.default_prog = { prefix .. '/bin/fish', '-l' }

return cfg
