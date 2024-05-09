{
  imports = [
    ./settings.nix
    ./binds.nix
    ./rose-pine.nix
    ./hypridle.nix
    ./hyprlock.nix
    ./hyprpaper.nix
  ];
  wayland.windowManager.hyprland.enable = true;
  wayland.windowManager.hyprland.systemd.variables = [ "--all" ];
}
