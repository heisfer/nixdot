{pkgs, ...}: {
  imports = [
    ./hyprland.nix
    ./xdg.nix
    ../waybar
    ../rofi
    ../ags
    #    ../hyprpaper
  ];
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  home.sessionVariables = {
    QT_QPA_PLATFORM = "wayland";
    SDL_VIDEODRIVER = "wayland";
    XDG_SESSION_TYPE = "wayland";
  };
  programs.obs-studio.enable = true;
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
