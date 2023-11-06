{...}: {
  imports = [
    ../editors/helix
    ../default.nix
    ../wayland/hyprland
    ../waybar
    ../mako
    ../rofi
    ../gtk
  ];

  systemd.user.startServices = "sd-switch";
  programs.home-manager.enable = true;

  home = {
    username = "heisfer";
    homeDirectory = "/home/heisfer";
    stateVersion = "23.05";
  };
}
