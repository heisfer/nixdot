{ inputs, pkgs, ... }:
{
  imports = [
    ./settings.nix
    ./binds.nix
    ./rose-pine.nix
  ];
  wayland.windowManager.hyprland.enable = true;
  wayland.windowManager.hyprland.package = inputs.hyprland.packages.${pkgs.system}.default;
  wayland.windowManager.hyprland.systemd.variables = [ "--all" ];
}
