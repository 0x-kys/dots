local wezterm = require 'wezterm'

local config = {} 

config.color_scheme = '3024 (base16)'

config.font = wezterm.font_with_fallback {
  'JetBrains Mono Nerd Font',
}

config.front_end = "WebGpu"
config.font_size = 10.0
config.enable_tab_bar = false
config.window_padding = {
  left = 6,
  right = 6,
  top = 6,
  bottom = 6,
}

return config
