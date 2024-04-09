{outputs, ...}: {
  imports = [
    ./internet
    ./wayland
    ./terminal
    ./packages.nix
    ./shell
    ./editor
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
