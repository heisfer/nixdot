{
  inputs,
  self,
  outputs,
  ...
}:
{
  imports = [
    ./internet
    ./wayland
    ./programs
    ./terminal
    ./packages.nix
    ./services
    ./shell
    ./editor
    inputs.ags.homeManagerModules.default
    inputs.hyprland.homeManagerModules.default
    self.homeManagerModules.default
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
