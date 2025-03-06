{ inputs, ... }:
{
  programs.hyprpaper.enable = true;
  programs.hyprpaper.settings = ''
    ipc = off
    preload = ${inputs.wallpapers}/summer-night.png
    wallpaper = ,${inputs.wallpapers}/summer-night.png
  '';
}
