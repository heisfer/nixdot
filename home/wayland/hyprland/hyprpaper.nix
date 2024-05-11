{ config, ... }:
{
  services.hyprpaper = {
    enable = true;
    settings = {
      splash = false;
      #FIXME: later to add wallpaper attribute instead of getting it from my home dir
      preload = [ "${config.home.homeDirectory}/cat.png" ];
      wallpaper = [ " , ${config.home.homeDirectory}/cat.png" ];
    };
  };
}
