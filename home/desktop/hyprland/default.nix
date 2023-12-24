{
  inputs,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./config.nix
  ];

  # enable hyprland
  wayland.windowManager.hyprland = {
    enable = true;
    # plugins = [inputs.hyprland-plugins.packages.${pkgs.system}.csgo-vulkan-fix];
  };
}
