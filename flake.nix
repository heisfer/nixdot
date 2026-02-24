# flake.nix
{
  inputs = {
    nixpkgs = {
      type = "github";
      owner = "NixOS";
      repo = "nixpkgs";
      ref = "nixos-unstable";
    };
    disko = {
      type = "github";
      owner = "nix-community";
      repo = "disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    impermanence = {
      type = "github";
      owner = "nix-community";
      repo = "impermanence";
    };
    flake-parts = {
      type = "github";
      owner = "hercules-ci";
      repo = "flake-parts";
    };
    vaultix = {
      type = "github";
      owner = "milieuim";
      repo = "vaultix";
    };
    git-hooks-nix = {
      type = "github";
      owner = "cachix";
      repo = "git-hooks.nix";
    };
  };

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      # test is a hostname for our machine
      imports = [
        inputs.git-hooks-nix.flakeModule
      ];
      systems = [
        "x86_64-linux"
      ];
      perSystem =
        {
          pkgs,
          system,
          config,
          lib,
          ...
        }:
        {
          pre-commit = {
            check.enable = true;
            settings.hooks = {
              nixfmt.enable = true;
              detect-private-keys.enable = true;
            };
          };

          devShells.default = pkgs.mkShell {
            shellHook = ''
              nu
            ''
            + config.pre-commit.installationScript;

            buildInputs = with pkgs; [
              just
              nushell
            ];
          };

          formatter = pkgs.nixfmt-tree;

        };
      flake = {
        vaultix = {
          cache = "./secrets/cache";
          identity = "~/.ssh/id_ed25519";
        };
        nixosConfigurations.voyage = inputs.nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./configurations.nix
            ./disko.nix
            ./impermanence.nix
            ./vm.nix
            ./perless.nix
            ./vaultix.nix
            inputs.vaultix.nixosModules.default
          ];
          specialArgs = { inherit inputs; };

        };
      };
    };
}
