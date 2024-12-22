{ inputs, ylib, ... }:
{
  imports = ylib.umport {
    paths = [
      ./terminal
      ./programs
      ./wayland
      ./services
    ];
    recursive = true;
  };

  nixpkgs = {
    overlays = [
      inputs.nur.overlay.default
    ];
  };
  home = {
    username = "heisfer";
    homeDirectory = "/home/heisfer";
  };
  home.stateVersion = "24.11";
}
