{
  flake.nixosModules.losfelt =
    { lib, config, ... }:
    let
      inherit (lib) mkIf mkEnableOption;
      cfg = config.losfelt.hardware.fingerprint;
    in
    {
      options.losfelt.hardware.fingerprint.enable = mkEnableOption "fingerprint";

      config = mkIf cfg.enable {
        services.fprintd.enable = true;
      };
    };
}
