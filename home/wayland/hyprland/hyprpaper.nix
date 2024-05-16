{ inputs, ... }:
{
  services.hyprpaper = {
    enable = true;
    settings = {
      splash = false;
      preload = [ "${inputs.wallpapers}/rose-pine-nix.png" ];
      wallpaper = [ " , ${inputs.wallpapers}/rose-pine-nix.png" ];
    };
  };
}
