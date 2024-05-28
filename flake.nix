{
  description = "Heisfer's nixdot";

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [ ./pkgs ];
      systems = [ "x86_64-linux" ];
      perSystem =
        { pkgs, ... }:
        {
          formatter = pkgs.nixfmt-rfc-style;
        };
      flake =
        { self', ... }:
        {
          nixosConfigurations.voyage = inputs.nixpkgs.lib.nixosSystem {
            specialArgs = {
              inherit inputs;
            };
            system = "x86_64-linux";
            modules = [
              ./nixos
              ./nixos/modules
              inputs.home-manager.nixosModules.home-manager
              {
                home-manager = {
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  users.heisfer = import ./home;
                  extraSpecialArgs = {
                    inherit inputs self';
                  };
                };
              }
            ];
          };
        };
    };
  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nur.url = "github:nix-community/nur";

    waybar-rose-pine.url = "github:rose-pine/waybar";
    waybar-rose-pine.flake = false;

    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
    nixneovimplugins = {
      url = "github:jooooscha/nixpkgs-vim-extra-plugins";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    helix.url = "github:helix-editor/helix";
    nil = {
      url = "github:oxalica/nil";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    wallpapers = {
      url = "github:heisfer/Wallpapers";
      flake = false;
    };

    rose-pine-rofi = {
      url = "github:heisfer/rose-pine-rofi";
      flake = false;
    };
    ags = {
      url = "github:Aylur/ags";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
  };
}
