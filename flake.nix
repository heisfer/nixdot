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
    # probably will have secrets lated things on here
    # nixdot-private = {
    #   type = "github";
    #   owner = "heisfer";
    #   repo = "nixdot-private";
    #   flake = false;
    # };
    import-tree = {
      type = "github";
      owner = "vic";
      repo = "import-tree";
    };

  };

  outputs =
    inputs@{ flake-parts, self, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      # test is a hostname for our machine
      imports = [
        inputs.git-hooks-nix.flakeModule
        inputs.vaultix.flakeModules.default
        (inputs.import-tree ./modules)
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
            shellHook = config.pre-commit.installationScript;

            buildInputs = with pkgs; [
              just
              rage
            ];
          };

          formatter = pkgs.nixfmt-tree;

        };
      flake = {
        vaultix = {
          identity = "./secrets/key.txt";
        };
      };
    };
}
