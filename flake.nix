{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur.url = "github:nix-community/nur";
    kak-rose-pine = {
      url = "git+https://gitea.nulo.in/Nulo/rose-pine.kak.git";
      flake = false;
    };
    heisfer-nixvim.url = "git+file:///home/heisfer/Projects/nix/nvim";
    hyprpaper.url = "github:hyprwm/hyprpaper";
    hyprlock.url = "github:hyprwm/hyprlock";
    hypridle.url = "github:hyprwm/hypridle";
    hyprland.url = "github:hyprwm/Hyprland";
    waybar-rose-pine = {
      url = "github:rose-pine/waybar";
      flake = false;
    };

    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    inherit (self) outputs;
  in {
    overlays."local" = final: _prev: import ./pkgs {pkgs = final;};
    nixosConfigurations.voyage = nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit inputs;
      };
      system = "x86_64-linux";
      modules = [
        ./nixos
        ./modules
        inputs.home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.heisfer = import ./home;
            extraSpecialArgs = {inherit inputs outputs;};
          };
        }
      ];
    };
  };
}
