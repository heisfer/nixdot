{...}: {
  imports = [
    ./hyprland
    ./ags
    ./rofi
    ./gtk.nix
    ./xdg.nix
  ];

  home.sessionVariables = {
    QT_QPA_PLATFORM = "wayland";
    SDL_VIDEODRIVER = "wayland";
    XDG_SESSION_TYPE = "wayland";
  };
}
