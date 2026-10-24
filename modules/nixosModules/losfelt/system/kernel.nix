{
  flake.nixosModules.losfelt =
    {
      lib,
      config,
      pkgs,
      ...
    }:
    let
      inherit (lib)
        mkOption
        mkDefault
        optional
        literalMD
        ;
      inherit (lib.types) enum raw;
      cfg = config.losfelt.system.kernel;

      # flavour -> track -> candidates, preferred first.
      # An empty list means "this flavour has no such track".
      flavours = {
        vanilla = {
          latest = [
            pkgs.linuxPackages_latest
            pkgs.linuxPackages
          ];
          lts = [ pkgs.linuxPackages ];
        };
        xanmod = {
          latest = [
            pkgs.linuxPackages_xanmod_latest
            pkgs.linuxPackages_xanmod_stable
          ];
          lts = [ pkgs.linuxPackages_xanmod ];
        };
        zen = {
          latest = [ pkgs.linuxPackages_zen ];
          lts = [ ];
        };
      };

      # With ZFS enabled, skip kernels whose ZFS module is marked broken.
      zfsOk =
        k:
        !config.boot.zfs.enabled
        || !((k.${config.boot.zfs.package.kernelModuleAttribute}).meta.broken or false);

      pick = flavour: builtins.filter zfsOk flavours.${flavour}.${cfg.track};

      preferred = pick cfg.flavour;
      fallback = pick "vanilla";

      chosen =
        if preferred != [ ] then
          builtins.head preferred
        else if fallback != [ ] then
          builtins.head fallback
        else
          pkgs.linuxPackages;
    in
    {
      options.losfelt.system.kernel = {
        flavour = mkOption {
          type = enum (builtins.attrNames flavours);
          default = "vanilla";
          description = "Kernel family. Falls back to vanilla if nothing in it is usable.";
        };

        track = mkOption {
          type = enum [
            "latest"
            "lts"
          ];
          default = "latest";
          description = "Release track. Flavours without that track fall back to vanilla.";
        };

        package = mkOption {
          type = raw;
          readOnly = true;
          default = chosen;
          defaultText = literalMD "The newest ZFS-compatible kernel package set for the chosen flavour and track.";
          description = "The kernel package set that was resolved.";
        };
      };

      config = {
        boot.kernelPackages = mkDefault cfg.package;

        warnings =
          optional (cfg.flavour != "vanilla" && preferred == [ ])
            "losfelt.system.kernel: no usable `${cfg.flavour}` kernel on the `${cfg.track}` track, falling back to vanilla";
      };
    };
}
