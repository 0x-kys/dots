-- WezTerm Configuration
-- Matching Ghostty config style

local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- ==========================================
-- VISUALS & THEME
-- ==========================================

-- Custom Monochrome Theme (monolith)
-- Pure black background matching Waybar/Hyprland
config.color_scheme = "monolith"

-- Window decorations: none (minimal)
config.window_decorations = "NONE"

-- Background: pure black, fully opaque
config.window_background_opacity = 1.0
config.macos_window_background_blur = 0

-- ==========================================
-- FONT
-- ==========================================

config.font = wezterm.font("JetBrainsMono Nerd Font")
config.font_size = 9.0

-- ==========================================
-- WINDOW PADDING
-- ==========================================

config.window_padding = {
  left = "2px",
  right = "2px",
  top = "2px",
  bottom = "2px",
}

-- ==========================================
-- CURSOR & SELECTION
-- ==========================================

config.default_cursor_style = "BlinkingBlock"
config.cursor_blink_rate = 500
config.cursor_blink_ease_in = "Constant"
config.cursor_blink_ease_out = "Constant"

-- ==========================================
-- TABS - MINIMAL VIEW
-- ==========================================

-- Hide tab bar when only one tab
config.hide_tab_bar_if_only_one_tab = true

-- Minimal tab bar style
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = false
config.show_new_tab_button_in_tab_bar = false
config.tab_max_width = 25
config.cursor_blink_ease_in = 'EaseOut'
config.cursor_blink_ease_out = 'EaseOut'
config.default_cursor_style = 'BlinkingBlock'
config.cursor_blink_rate = 650

-- Custom Monochrome Color Palette (monolith theme)
config.color_schemes = {
  ["monolith"] = {
    -- Base colors
    foreground = "#e0e0e0",  -- Light gray text (matches Waybar)
    background = "#000000",  -- Pure black (matches Waybar/Hyprland)
    cursor_bg = "#ffffff",   -- Pure white cursor
    cursor_fg = "#000000",   -- Black cursor text
    cursor_border = "#ffffff", -- White cursor border
    selection_fg = "#ffffff", -- White selected text
    selection_bg = "#303030", -- Dark gray selection (matches borders)

    -- Scrollbar
    scrollbar_thumb = "#505050",

    -- Split separators
    split = "#303030",

    -- ANSI colors (Monochrome palette - all grays)
    ansi = {
      "#000000", -- Black (pure black)
      "#909090", -- Red → Gray (for errors)
      "#c0c0c0", -- Green → Light gray (for success)
      "#a0a0a0", -- Yellow → Mid gray (for warnings)
      "#808080", -- Blue → Gray (for info)
      "#b0b0b0", -- Magenta → Gray
      "#d0d0d0", -- Cyan → Light gray
      "#e0e0e0", -- White → Off-white
    },

    -- Bright ANSI colors (Brighter grays)
    brights = {
      "#303030", -- Bright Black → Dark gray
      "#a0a0a0", -- Bright Red → Gray
      "#d0d0d0", -- Bright Green → Light gray
      "#b0b0b0", -- Bright Yellow → Gray
      "#909090", -- Bright Blue → Gray
      "#c0c0c0", -- Bright Magenta → Light gray
      "#e0e0e0", -- Bright Cyan → Off-white
      "#ffffff", -- Bright White → Pure white
    },

    -- Tab bar colors
    tab_bar = {
      background = "#000000",

      active_tab = {
        bg_color = "#505050",
        fg_color = "#ffffff",
        intensity = "Bold",
      },

      inactive_tab = {
        bg_color = "#1a1a1a",
        fg_color = "#808080",
      },

      inactive_tab_hover = {
        bg_color = "#303030",
        fg_color = "#b0b0b0",
      },

      new_tab = {
        bg_color = "#000000",
        fg_color = "#808080",
      },

      new_tab_hover = {
        bg_color = "#303030",
        fg_color = "#ffffff",
      },
    },
  },
}

-- ==========================================
-- SHELL INTEGRATION
-- ==========================================

config.default_prog = { "/usr/bin/fish" }

-- ==========================================
-- KEYBINDINGS (matching Ghostty + splits)
-- ==========================================

local act = wezterm.action

config.keys = {
  {
    key = "F11",
    mods = "NONE",
    action = wezterm.action.ToggleFullScreen,
  },

  -- Tab management
  {
    key = "t",
    mods = "CTRL|ALT",
    action = act.ShowTabNavigator,
  },
  {
    key = "t",
    mods = "CTRL|SHIFT",
    action = act.SpawnTab("CurrentPaneDomain"),
  },
  {
    key = "w",
    mods = "CTRL|SHIFT",
    action = act.CloseCurrentTab({ confirm = true }),
  },
  {
    key = "l",
    mods = "CTRL|SHIFT",
    action = act.ActivateTabRelative(1),
  },
  {
    key = "h",
    mods = "CTRL|SHIFT",
    action = act.ActivateTabRelative(-1),
  },

  -- Splits (matching Ghostty split concepts)
  {
    key = "o",
    mods = "CTRL|SHIFT",
    action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
  },
  {
    key = "e",
    mods = "CTRL|SHIFT",
    action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
  },
  {
    key = "w",
    mods = "ALT",
    action = act.CloseCurrentPane({ confirm = true }),
  },

  -- Navigate splits
  {
    key = "h",
    mods = "CTRL|ALT",
    action = act.ActivatePaneDirection("Left"),
  },
  {
    key = "l",
    mods = "CTRL|ALT",
    action = act.ActivatePaneDirection("Right"),
  },
  {
    key = "k",
    mods = "CTRL|ALT",
    action = act.ActivatePaneDirection("Up"),
  },
  {
    key = "j",
    mods = "CTRL|ALT",
    action = act.ActivatePaneDirection("Down"),
  },

  -- Resize splits
  {
    key = "LeftArrow",
    mods = "CTRL|SHIFT",
    action = act.AdjustPaneSize({ "Left", 5 }),
  },
  {
    key = "RightArrow",
    mods = "CTRL|SHIFT",
    action = act.AdjustPaneSize({ "Right", 5 }),
  },
  {
    key = "UpArrow",
    mods = "CTRL|SHIFT",
    action = act.AdjustPaneSize({ "Up", 5 }),
  },
  {
    key = "DownArrow",
    mods = "CTRL|SHIFT",
    action = act.AdjustPaneSize({ "Down", 5 }),
  },

  -- Copy/Paste
  {
    key = "c",
    mods = "CTRL|SHIFT",
    action = act.CopyTo("Clipboard"),
  },
  {
    key = "v",
    mods = "CTRL|SHIFT",
    action = act.PasteFrom("Clipboard"),
  },

  -- Font size
  {
    key = "+",
    mods = "CTRL",
    action = act.IncreaseFontSize,
  },
  {
    key = "-",
    mods = "CTRL",
    action = act.DecreaseFontSize,
  },
  {
    key = "0",
    mods = "CTRL",
    action = act.ResetFontSize,
  },

  -- Scrollback
  -- {
  --   key = "l",
  --   mods = "CTRL|ALT",
  --   action = act.ClearScrollback("ScrollbackAndViewport"),
  -- },
  {
    key = "PageUp",
    mods = "SHIFT",
    action = act.ScrollByPage(-1),
  },
  {
    key = "PageDown",
    mods = "SHIFT",
    action = act.ScrollByPage(1),
  },

  -- Quick select (URL/path picker)
  {
    key = "Space",
    mods = "CTRL|SHIFT",
    action = act.QuickSelect,
  },

  -- Search
  {
    key = "f",
    mods = "CTRL|SHIFT",
    action = act.Search("CurrentSelectionOrEmptyString"),
  },
}

-- ==========================================
-- MOUSE BINDINGS
-- ==========================================

config.mouse_bindings = {
  -- Right click pastes from clipboard
  {
    event = { Down = { streak = 1, button = "Right" } },
    mods = "NONE",
    action = act.PasteFrom("Clipboard"),
  },
  -- Change the default click behavior so that it only selects text
  {
    event = { Up = { streak = 1, button = "Left" } },
    mods = "NONE",
    action = act.CompleteSelection("ClipboardAndPrimarySelection"),
  },
  -- CTRL-Click open hyperlinks
  {
    event = { Up = { streak = 1, button = "Left" } },
    mods = "CTRL",
    action = act.OpenLinkAtMouseCursor,
  },
}

-- ==========================================
-- MISC SETTINGS
-- ==========================================

-- Performance
config.animation_fps = 144
config.max_fps = 144

-- Scrollback
config.scrollback_lines = 10000

-- Close confirmation
config.window_close_confirmation = "NeverPrompt"

-- Disable bell
config.audible_bell = "Disabled"

-- Unfocused pane dimming (matching Ghostty's unfocused-split-opacity = 1)
config.inactive_pane_hsb = {
  saturation = 1.0,
  brightness = 1.0,
}

return config
