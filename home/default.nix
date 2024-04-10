{
  inputs,
  outputs,
  ...
}: {
  imports = [
    ./internet
    ./wayland
    ./terminal
    ./packages.nix
    ./shell
    ./editor
    inputs.hypridle.homeManagerModules.default
    inputs.hyprlock.homeManagerModules.default
  ];

  nixpkgs = {
    overlays = [
      outputs.overlays.local
    ];
  };

  home = {
    username = "heisfer";
    homeDirectory = "/home/heisfer";
    stateVersion = "24.05";
  };
}
