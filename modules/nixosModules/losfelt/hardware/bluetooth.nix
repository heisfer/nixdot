{
  flake.nixosModules.losfelt = { lib, config, ... }: {
    options.losfelt.hardware.bluetooth.enable = lib.mkEnableOption "bluetooth";

    config = lib.mkIf config.losfelt.hardware.bluetooth.enable {
      hardware.bluetooth.enable = true;
    };
  };
}
