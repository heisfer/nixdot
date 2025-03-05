{
  outputs =
    inputs@{ self, ... }:
    {
      nixosConfigurations.voyage = inputs.nixpkgs.lib.nixosSystem {
        modules = [
          ./configuration.nix
        ];
        specialArgs = {
          inherit inputs;
        };
      };
      formatter.x86_64-linux = inputs.nixpkgs.legacyPackages.x86_64-linux.nixfmt-rfc-style;
    };
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # MASTER BRANCH
    hyprland.url = "github:hyprwm/hyprland";
  };
}
