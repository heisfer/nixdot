{
  description = "Description for the project";

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports =
        [
        ];
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];
      perSystem =
        {
          config,
          self',
          inputs',
          pkgs,
          system,
          ...
        }:
        {
          formatter = pkgs.nixfmt-rfc-style;
        };
      flake = {
        nixosConfigurations = {
          voyage = inputs.nixpkgs.lib.nixosSystem {
            modules = [
              ./system/voyage/configuration.nix
              inputs.home-manager.nixosModules.home-manager
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.users.heisfer = import ./home;
                home-manager.extraSpecialArgs = {
                  inherit inputs;
                  ylib = inputs.nypkgs.lib."x86_64-linux";
                };
              }
            ];
            specialArgs = {
              ylib = inputs.nypkgs.lib."x86_64-linux";
            };
          };
        };
        homeConfigurations = {
          "heisfer@voyage" = inputs.home-manager.lib.homeManagerConfiguration {
            pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
            extraSpecialArgs = {
              inherit inputs;
              ylib = inputs.nypkgs.lib."x86_64-linux";
            };
          };
        };
      };
    };

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # For umport :)
    nypkgs = {
      url = "github:yunfachi/nypkgs";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    helix = {
      url = "github:helix-editor/helix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dotmod = {
      url = "git+file:///home/heisfer/Projects/nix/modules";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
