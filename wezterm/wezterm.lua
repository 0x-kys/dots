-- WezTerm Configuration
-- Matching Ghostty config style

local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- ==========================================
-- VISUALS & THEME
-- ==========================================

-- Color scheme: Gruvbox Dark (matching Ghostty)
config.color_scheme = "Gruvbox Dark (Gogh)"

-- Window decorations: server-side (matching Ghostty)
config.window_decorations = "NONE"

-- Background
config.window_background_opacity = 0.95
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

-- Tab styling and background color override
config.colors = {
  -- Override background to pure black
  background = "#000000",

  tab_bar = {
    -- The color of the strip that goes along the top of the window
    -- (does not apply when fancy tab bar is in use)
    background = '#000000',

    -- The active tab is the one that has focus in the window
    active_tab = {
      -- The color of the background area for the tab
      bg_color = '#808080',
      -- The color of the text for the tab
      fg_color = '#000000',

      -- Specify whether you want "Half", "Normal" or "Bold" intensity for the
      -- label shown for this tab.
      -- The default is "Normal"
      intensity = 'Normal',

      -- Specify whether you want "None", "Single" or "Double" underline for
      -- label shown for this tab.
      -- The default is "None"
      underline = 'None',

      -- Specify whether you want the text to be italic (true) or not (false)
      -- for this tab.  The default is false.
      italic = false,

      -- Specify whether you want the text to be rendered with strikethrough (true)
      -- or not for this tab.  The default is false.
      strikethrough = false,
    },

    -- Inactive tabs are the tabs that do not have focus
    inactive_tab = {
      bg_color = '#202020',
      fg_color = '#808080',

      -- The same options that were listed under the `active_tab` section above
      -- can also be used for `inactive_tab`.
    },

    -- You can configure some alternate styling when the mouse pointer
    -- moves over inactive tabs
    inactive_tab_hover = {
      bg_color = '#3b3052',
      fg_color = '#909090',
      italic = true,

      -- The same options that were listed under the `active_tab` section above
      -- can also be used for `inactive_tab_hover`.
    },

    -- The new tab button that let you create new tabs
    new_tab = {
      bg_color = '#1b1032',
      fg_color = '#808080',

      -- The same options that were listed under the `active_tab` section above
      -- can also be used for `new_tab`.
    },

    -- You can configure some alternate styling when the mouse pointer
    -- moves over the new tab button
    new_tab_hover = {
      bg_color = '#3b3052',
      fg_color = '#909090',
      italic = true,

      -- The same options that were listed under the `active_tab` section above
      -- can also be used for `new_tab_hover`.
    },
  },

  -- tab_bar = {
  --   background = "#000000",
  --   active_tab = {
  --     bg_color = "#444444",
  --     fg_color = "#ffffff",
  --     intensity = "Bold",
  --   },
  --   inactive_tab = {
  --     bg_color = "#1a1a1a",
  --     fg_color = "#808080",
  --   },
  --   inactive_tab_hover = {
  --     bg_color = "#333333",
  --     fg_color = "#ffffff",
  --   },
  --   new_tab = {
  --     bg_color = "#000000",
  --     fg_color = "#808080",
  --   },
  --   new_tab_hover = {
  --     bg_color = "#333333",
  --     fg_color = "#ffffff",
  --   },
  -- },
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
