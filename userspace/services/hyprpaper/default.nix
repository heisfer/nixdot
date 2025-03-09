{ inputs, ... }:
{
  services.hyprpaper.enable = true;
  services.hyprpaper.settings = ''
    ipc = off
    preload = ${inputs.wallpapers}/summer-night.png
    preload = ${inputs.wallpapers}/deskresearch.png
    wallpaper = ,${inputs.wallpapers}/deskresearch.png
  '';
}
