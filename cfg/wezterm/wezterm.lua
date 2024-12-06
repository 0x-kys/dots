local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.colors = {
  foreground = '#DCD7BA',
  background = '#0D0C0D',

  cursor_bg = '#DCD7BA',
  cursor_fg = '#1F1F28',
  cursor_border = '#DCD7BA',

  selection_fg = '#DCD7BA',
  selection_bg = '#7E9CD8',

  ansi = {
    '#090618',
    '#C34043',
    '#76946A',
    '#C0A36E',
    '#7E9CD8',
    '#957FB8',
    '#6A9589',
    '#C8C093',
  },

  brights = {
    '#141414',
    '#E82424',
    '#98BB6C',
    '#E6C384',
    '#7FB4CA',
    '#938AA9',
    '#7AA89F',
    '#DCA561',
  },
}

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
