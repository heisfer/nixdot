{
  imports = [
    ./settings.nix
    ./binds.nix
    ./rose-pine.nix
  ];
  wayland.windowManager.hyprland.enable = true;
  wayland.windowManager.hyprland.systemd.variables = ["--all"];
}
