{
  nixConfig = {
    extra-substituters = [
      "https://helix.cachix.org"
    ];
    extra-trusted-public-keys = [
      "helix.cachix.org-1:ejp9KQpR1FBI2onstMQ34yogDm4OgU2ru6lIwPvuCVs="
    ];
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
      # (mkSystem {
      #   hostname = "zenith";
      #   extraModules = [
      #     ./systems/zenith
      #     inputs.hjem.nixosModules.default
      #     inputs.lix-module.nixosModules.default
      #   ];
      #   specialArgs = { inherit inputs; };
      #   overlays = [
      #     self.overlays.local-packages
      #     self.overlays.small
      #   ];

      # })
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

    # Remove this on next relase.
    helix-master.url = "github:helix-editor/helix";

    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.93.0.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-minecraft.url = "github:heisfer/nix-minecraft/geyser";

    nixtheplanet.url = "github:matthewcroughan/nixtheplanet";

    nil = {
      url = "github:oxalica/nil";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
