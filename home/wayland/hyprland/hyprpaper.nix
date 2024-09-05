{ inputs, pkgs, ... }:
{
  services.hyprpaper = {
    enable = true;
    package = inputs.hyprpaper.packages.${pkgs.system}.default;
    settings = {
      splash = false;
      preload = [ "${inputs.wallpapers}/rose-pine-nix.png" ];
      wallpaper = [ " , ${inputs.wallpapers}/rose-pine-nix.png" ];
    };
  };
}
