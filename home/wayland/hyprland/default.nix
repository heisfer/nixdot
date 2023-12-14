{pkgs, ...}: {
  imports = [
    ./hyprland.nix
    ./xdg.nix
    # ../waybar
    ../rofi
    ../ags
    ../swaylock
    #    ../hyprpaper
  ];
  wayland.windowManager.hyprland = {
    enable = true;
    systemdIntegration = true;
    recommendedEnvironment = true;
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
      gnome.nautilus
      brightnessctl
    ];
  };
}
