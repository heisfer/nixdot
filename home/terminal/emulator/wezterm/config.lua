local wezterm = require ('wezterm')
local theme = wezterm.plugin.require('https://github.com/neapsix/wezterm').main
local act = wezterm.action
local config = {}

return {
  font = wezterm.font_with_fallback({
    { family = "BlexMono Nerd Font Mono", weight = "Medium", stretch = "Normal", style = "Normal" },
  }),
  font_size = 12;
  enable_wayland = true,
  colors = theme.colors(),
  enable_tab_bar = false,
  default_cursor_style = 'SteadyBar',
  cursor_thickness = 2,
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
