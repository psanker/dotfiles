local wezterm = require 'wezterm'

return {
  default_prog = { '/usr/local/bin/fish', '-l' },
  font = wezterm.font('FiraCode Nerd Font', { italic = false }),
  send_composed_key_when_left_alt_is_pressed = true,
  color_scheme = "Gruber (base16)",
  hide_tab_bar_if_only_one_tab = true,
}
