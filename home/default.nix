{ inputs, outputs, ... }:
{
  imports = [
    ./internet
    ./wayland
    ./terminal
    ./packages.nix
    ./services
    ./shell
    ./editor
    inputs.ags.homeManagerModules.default
    inputs.hyprland.homeManagerModules.default
  ];

  nixpkgs = {
    overlays = [
      outputs.overlays.local
      inputs.nur.overlay
      inputs.nixneovimplugins.overlays.default
    ];
  };

  home = {
    username = "heisfer";
    homeDirectory = "/home/heisfer";
    stateVersion = "24.05";
  };
}
