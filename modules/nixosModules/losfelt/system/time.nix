{
  flake.nixosModules.losfelt =
    { lib, config, ... }:
    let
      inherit (lib) mkOption types mkIf;
      cfg = config.losfelt.system.timeZone;
    in
    {
      options.losfelt.system.timeZone = mkOption {
        default = "auto";
        type = types.str;
      };

      config = {
        services.automatic-timezoned.enable = cfg == "auto";
        time.timeZone = mkIf (cfg != "auto") cfg;
      };
    };
}
