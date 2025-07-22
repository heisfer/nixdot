{ inputs, pkgs, ... }:
{
  programs.wezterm = {
    enable = true;
    # package = inputs.wezterm-master.packages.${pkgs.system}.default;
    default = true;
    settings = # lua
      ''
        local wezterm = require 'wezterm'

        local theme = wezterm.plugin.require('https://github.com/neapsix/wezterm').main

        local config = wezterm.config_builder()

        config = {
          font = wezterm.font('BlexMono Nerd Font Propo', { weight = 'Medium'}),
          colors = theme.colors(),
          window_frame = theme.window_frame(),
          enable_tab_bar = false,
          enable_wayland = true,
          default_cursor_style = 'SteadyBar',
          cursor_thickness = 2,
        }

        return config

      '';
  };
}
