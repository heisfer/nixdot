{ pkgs, inputs, ... }:
{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    theme = inputs.rose-pine-rofi + "/rose-pine.rasi";
  };
}
