{
  flake.nixosModules.losfelt =
    {
      lib,
      pkgs,
      config,
      ...
    }:
    let
      inherit (lib) mkOption mkIf;
      inherit (lib.types) enum;
      cfg = config.losfelt.system.nix;

      engine = {
        lix = pkgs.lixPackageSets.latest.lix;
        nix = pkgs.nixVersions.latest;
      };
    in
    {

      options.losfelt.system.nix = {
        engine = mkOption {
          type = enum [
            "nix"
            "lix"
          ];
          default = "nix";
          description = "What nix to use";
        };

      };
      config = {
        programs.nh = {
          enable = true;
          flake = "/home/heisfer/Projects/nixdots"; # tmp
        };
        documentation = {
          enable = false;
          man.enable = false;
          doc.enable = false;
          info.enable = false;
        };
        nix = {
          channel.enable = false;
          package = engine.${cfg.engine};
          nixPath = [ "nixpkgs=flake:nixpkgs" ];

          settings = {
            experimental-features = [
              "nix-command"
              "flakes"
              # "pipe-operators"
            ];
            auto-optimise-store = true;
            warn-dirty = false;
            connect-timeout = 5;
            builders-use-substitutes = true;
            allowed-users = [ "@wheel" ];
            trusted-users = [ "@wheel" ];
          };
        };
        nixpkgs.config.allowUnfree = true;
      };
    };
}
