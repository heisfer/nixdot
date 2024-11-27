{ inputs, ylib, ... }:
{
  imports = ylib.umport {
    paths = [
      ./terminal
      ./programs
      ./wayland
    ];
    recursive = true;
  };

  nixpkgs = {
    overlays = [
      inputs.nur.overlay
    ];
  };
  home = {
    username = "heisfer";
    homeDirectory = "/home/heisfer";
  };
  home.stateVersion = "24.11";
}
