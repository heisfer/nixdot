{ inputs, pkgs, ... }:
{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    theme = inputs.rofi-rose-pine + "/rose-pine.rasi";
  };
}
