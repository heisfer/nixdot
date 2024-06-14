{
  inputs,
  self,
  outputs,
  ...
}:
{
  imports = [
    ./packages.nix
    ./programs
    ./services
    ./terminal
    ./wayland
    inputs.ags.homeManagerModules.default
    inputs.hyprland.homeManagerModules.default
    self.homeManagerModules.default
  ];

  nixpkgs = {
    overlays = [
      outputs.overlays.local
      inputs.nur.overlay
    ];
  };

  home = {
    username = "heisfer";
    homeDirectory = "/home/heisfer";
    stateVersion = "24.05";
  };
}
