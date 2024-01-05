{
  inputs,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./rose-pine.nix
    ./config.nix
    ./binds.nix
  ];

  # enable hyprland
  wayland.windowManager.hyprland = {
    enable = true;
    # plugins = [inputs.hyprland-plugins.packages.${pkgs.system}.csgo-vulkan-fix];
  };
}
