{
  flake.nixosModules.losfelt =
    {
      lib,
      config,
      pkgs,
      ...
    }:
    let
      inherit (lib) mkOption mkIf;
      inherit (lib.types) enum;

      types = [
        "laptop"
        "deskop"
        "server"
      ];
    in
    {
      options.losfelt.system.type = mkOption {
        type = enum types;
        default = "stable";
        description = "system type (could be used for specific things)";
      };

    };
}
