{
  inputs,
  lib,
  pkgs,
  ...
}: let
  dbus-hyprland-env = pkgs.writeTextFile {
    name = "dbus-hyprland-env";
    destination = "/bin/dbus-hyprland-environment";
    executable = true;
    text = ''
      dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=hyprland
      systemctl --user stop pipewire pipewire-media-session xdg-desktop-portal xdg-desktop-portal-wlr
      systemctl --user start pipewire wireplumber pipewire-media-session xdg-desktop-portal xdg-desktop-portal-hyprland
    '';
  };
in {
  home.packages = [
    dbus-hyprland-env
  ];
  imports = [
    ./rose-pine.nix
    ./config.nix
    ./binds.nix
  ];

  # enable hyprland
  wayland.windowManager.hyprland = {
    enable = true;
    # xwayland.enable = false;
    systemd = {
      enable = true;
      variables = ["--all"];
    };
    # plugins = [inputs.hyprland-plugins.packages.${pkgs.system}.csgo-vulkan-fix];
  };
}
