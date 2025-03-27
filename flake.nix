{
  nixConfig = {
    extra-substituters = [
      "https://hyprland.cachix.org"
      "https://prismlauncher.cachix.org"
      "https://helix.cachix.org"
      "https://wezterm.cachix.org"
    ];
    extra-trusted-public-keys = [
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "prismlauncher.cachix.org-1:9/n/FGyABA2jLUVfY+DEp4hKds/rwO+SCOtbOkDzd+c="
      "helix.cachix.org-1:ejp9KQpR1FBI2onstMQ34yogDm4OgU2ru6lIwPvuCVs="
      "wezterm.cachix.org-1:kAbhjYUC9qvblTE+s7S+kl5XM1zVa4skO+E/1IDWdH0="
    ];
  };

  outputs =
    inputs@{ self, ... }:
    let
      systems = [
        "aarch64-linux"
        "i686-linux"
        "x86_64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];
      forAllSystems = inputs.nixpkgs.lib.genAttrs systems;
      customLib = inputs.nixpkgs.lib.extend (final: prev: import ./lib/default.nix { lib = prev; });
    in
    {
      lib = customLib;
      nixosConfigurations.voyage = inputs.nixpkgs.lib.nixosSystem {
        inherit (self) lib;
        modules = [
          ./systems/voyage
          ./hjem
          ./servers/minecraft
          # inputs.dotmod.nixosModules.nixos
          inputs.hjem.nixosModules.default
          inputs.lix-module.nixosModules.default
          {
            nixpkgs.overlays = [
              self.overlays.local-packages
              self.overlays.small
            ];
            nix.registry = {
              self.flake = self;
            };
          }
        ];
        specialArgs = {
          inherit inputs;
        };
      };

      formatter.x86_64-linux = inputs.nixpkgs.legacyPackages.x86_64-linux.nixfmt-rfc-style;
      packages = forAllSystems (system: import ./pkgs inputs.nixpkgs.legacyPackages.${system});
      overlays = import ./flake/overlays.nix { inherit inputs; };
      templates = import ./templates;
    };
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-small.url = "github:NixOS/nixpkgs/nixos-unstable-small";

    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
    hjem = {
      url = "github:feel-co/hjem";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # OWN STYLES
    rofi-rose-pine = {
      url = "github:heisfer/rose-pine-rofi";
      flake = false;
    };

    swaync-rose-pine = {
      url = "github:rose-pine/swaync";
      flake = false;
    };

    wallpapers = {
      url = "github:heisfer/Wallpapers";
      flake = false;
    };

    # MASTER BRANCH / CACHIX
    hyprland.url = "github:hyprwm/hyprland";
    hyprsunset = {
      url = "github:hyprwm/hyprsunset";
      inputs = {
        nixpkgs.follows = "hyprland/nixpkgs";
        systems.follows = "hyprland/systems";
        hyprutils.follows = "hyprland/hyprutils";
        hyprwayland-scanner.follows = "hyprland/hyprwayland-scanner";
        hyprland-protocols.follows = "hyprland/hyprland-protocols";
      };
    };
    # helix-master.url = "github:helix-editor/helix";
    helix-master.url = "github:heisfer/helix/patchy";
    wezterm-master.url = "github:wezterm/wezterm?dir=nix";
    lightly = {
      url = "github:Bali10050/Darkly";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    prismlauncher = {
      url = "github:PrismLauncher/PrismLauncher";
      inputs = {
        flake-compat.follows = "";
      };
    };

    lix = {
      url = "git+https://git.lix.systems/lix-project/lix.git";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lix-module = {
      url = "git+https://git.lix.systems/lix-project/nixos-module.git";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.lix.follows = "lix";
    };

    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-minecraft.url = "github:heisfer/nix-minecraft/geyser";

    dotmod = {
      url = "git+file:///home/heisfer/Projects/system/modules";
    };
  };
}
