{
  outputs =
    inputs@{ self, ... }:
    {
      nixosConfigurations.voyage = inputs.nixpkgs.lib.nixosSystem {
        modules = [
          ./systems/voyage
          ./hjem
          inputs.hjem.nixosModules.default
        ];
        specialArgs = {
          inherit inputs;
        };
      };
      formatter.x86_64-linux = inputs.nixpkgs.legacyPackages.x86_64-linux.nixfmt-rfc-style;
    };
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    hjem = {
      url = "github:feel-co/hjem";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # MASTER BRANCH
    hyprland.url = "github:hyprwm/hyprland";

    # OWN STYLES
    rofi-rose-pine = {
      url = "github:heisfer/rose-pine-rofi";
      flake = false;
    };

    wallpapers = {
      url = "github:heisfer/Wallpapers";
      flake = false;
    };

  };
}
