{ inputs, outputs, ... }:
{
  imports = [
    ./internet
    ./wayland
    ./terminal
    ./packages.nix
    ./services.nix
    ./shell
    ./editor
    inputs.hyprlock.homeManagerModules.default
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
