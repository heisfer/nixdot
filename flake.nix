{
  description = "Description for the project";

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
      ];
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];
      perSystem =
        {
          # config,
          # self',
          # inputs',
          pkgs,
          # system,
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
              inputs.dotmod.nixosModules.swayosd
              inputs.hyprland.nixosModules.default
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
              inherit inputs;
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
            modules = [ ./home/default.nix ];
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
    nur.url = "github:nix-community/nur";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    wired = {
      url = "github:Toqozz/wired-notify";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dotmod = {
      url = "git+file:///home/heisfer/Projects/nix/modules";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Master Packages
    helix = {
      url = "github:helix-editor/helix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    wezterm = {
      url = "github:wez/wezterm?dir=nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Themes
    vesktop-rose-pine = {
      url = "github:toonoeichi/rosepine-discord-newthemes";
      flake = false;
    };

    rofi-rose-pine = {
      url = "github:heisfer/rose-pine-rofi";
      flake = false;
    };
    swaync-rose-pine = {
      url = "github:rose-pine/swaync";
      flake = false;
    };
    waybar-rose-pine = {
      url = "github:rose-pine/waybar";
      flake = false;
    };
  };
}
