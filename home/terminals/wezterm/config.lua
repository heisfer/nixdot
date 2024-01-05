local wezterm = require 'wezterm'
local act = wezterm.action
local config = {}

return {
  font = wezterm.font_with_fallback({
    { family = "Comic Code Ligatures", weight = "Regular", stretch = "Normal", style = "Normal" },
    "Noto Sans Symbols 2"
  }),
  enable_wayland = true,
  color_scheme = "Rosé Pine (Gogh)",
  enable_tab_bar = false,
  default_cursor_style = 'SteadyUnderline',
  window_padding = {
    left = 20,
    right = 20,
    top = 20,
    bottom = 20,
  },
  exit_behavior = 'CloseOnCleanExit',
  keys = {
    {
      key = 'u',
      mods = 'ALT',
      action = act.ActivatePaneDirection 'Up',
    },
    {
      key = 'e',
      mods = 'ALT',
      action = act.ActivatePaneDirection 'Down',
    },
  },
  mouse_bindings = {
    -- Scrolling up while holding CTRL increases the font size
    {
      event = { Down = { streak = 1, button = { WheelUp = 1 } } },
      mods = 'CTRL',
      action = act.IncreaseFontSize,
    },

    -- Scrolling down while holding CTRL decreases the font size
    {
      event = { Down = { streak = 1, button = { WheelDown = 1 } } },
      mods = 'CTRL',
      action = act.DecreaseFontSize,
    },

  },

}
