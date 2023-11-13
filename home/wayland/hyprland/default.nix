
{pkgs, ...}:{

  imports = [
    ./hyprland.nix
    ../gbar
#    ../hyprpaper
    
  ];
  xdg.configFile."scripts".source = ./scripts;
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = false;
  };
  home.sessionVariables = {
    QT_QPA_PLATFORM = "wayland";
    SDL_VIDEODRIVER = "wayland";
    XDG_SESSION_TYPE = "wayland";
  };
  programs.obs-studio.enable  = true;
  programs.obs-studio.plugins = with pkgs.obs-studio-plugins; [wlrobs];
  
  ##################################

  home = { 
    packages = with pkgs; [
      swww
      spot
      swayidle
      gnome.nautilus
      hyprpaper
      brightnessctl
    ];
  };


}   
