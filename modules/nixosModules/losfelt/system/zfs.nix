{
  flake.nixosModules.losfelt =
    { lib, config, pkgs, ... }:
    let
      inherit (lib) mkOption mkIf;
      inherit (lib.types) enum;
      cfg = config.losfelt.system.zfs;

      channels = {
        stable = pkgs.zfs;
        unstable = pkgs.zfs_unstable;
      };
    in
    {
      options.losfelt.system.zfs.channel = mkOption {
        type = enum (builtins.attrNames channels);
        default = "stable";
        description = "Which OpenZFS release to use.";
      };

      config = mkIf config.boot.zfs.enabled {
        boot.zfs.package = channels.${cfg.channel};
      };
    };
}
