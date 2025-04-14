{
  nixConfig = {
    # extra-substituters = [
    #   "https://hyprland.cachix.org"
    #   "https://prismlauncher.cachix.org"
    #   "https://helix.cachix.org"
    #   "https://wezterm.cachix.org"
    # ];
    # extra-trusted-public-keys = [
    #   "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
    #   "prismlauncher.cachix.org-1:9/n/FGyABA2jLUVfY+DEp4hKds/rwO+SCOtbOkDzd+c="
    #   "helix.cachix.org-1:ejp9KQpR1FBI2onstMQ34yogDm4OgU2ru6lIwPvuCVs="
    #   "wezterm.cachix.org-1:kAbhjYUC9qvblTE+s7S+kl5XM1zVa4skO+E/1IDWdH0="
    # ];
  };

  outputs =
    inputs@{ self, ... }:
    let
      customLib = inputs.nixpkgs.lib.extend (final: prev: import ./lib/default.nix { lib = prev; });
      inherit (customLib.dotmod.builder) mkSystem mkMerge forAllSystems;
    in
    mkMerge [
      (mkSystem {
        hostname = "voyage";
        extraModules = [
          ./systems/voyage
          ./servers/minecraft
          ./servers/darwin
          inputs.hjem.nixosModules.default
          inputs.lix-module.nixosModules.default
          inputs.nixdot-modules.nixosModules.hjem
          inputs.nixdot-modules.nixosModules.default
        ];
        specialArgs = { inherit inputs; };
        overlays = [
          self.overlays.local-packages
          self.overlays.small
        ];

      })
    ]
    // {
      lib = customLib;

      darwinConfigurations."azazel" = inputs.nix-darwin.lib.darwinSystem {
        modules = [ ./darwin/default.nix ];
        specialArgs = { inherit self; };
      };

      formatter.x86_64-linux = inputs.nixpkgs.legacyPackages.x86_64-linux.nixfmt-rfc-style;
      packages = forAllSystems (system: import ./pkgs inputs.nixpkgs.legacyPackages.${system});
      overlays = import ./flake/overlays.nix { inherit inputs; };
      templates = import ./templates;

      devShells = forAllSystems (
        system:
        let
          pkgs = inputs.nixpkgs.legacyPackages.${system};
        in
        {
          default = pkgs.mkShell {
            packages = [
              inputs.deploy-rs.packages.${system}.default
            ];
          };
        }
      );
    };
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-small.url = "github:NixOS/nixpkgs/nixos-unstable-small";

    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";

    hjem = {
      url = "github:feel-co/hjem";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixdot-modules.url = "github:heisfer/nixdot-modules";
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
    helix-master.url = "github:helix-editor/helix";
    wezterm-master.url = "github:wezterm/wezterm?dir=nix";
    lightly = {
      url = "github:Bali10050/Darkly";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    prismlauncher = {
      url = "github:PrismLauncher/PrismLauncher";
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

    nix-minecraft.url = "github:heisfer/nix-minecraft/geyser";

    nixtheplanet.url = "github:matthewcroughan/nixtheplanet";

  };
}
