{
  flake.nixosModules.losfelt =
    {
      lib,
      config,
      pkgs,
      ...
    }:
    let
      inherit (lib) mkEnableOption mkIf;
      cfg = config.losfelt.hardware.thrustmaster;
    in
    {
      options.losfelt.hardware.thrustmaster.enable =
        mkEnableOption "Thrustmaster T248/T300 wheel support (hid-tmff2)";

      config = mkIf cfg.enable {
        boot.blacklistedKernelModules = [ "hid-thrustmaster" ];
        boot.extraModulePackages = [ config.boot.kernelPackages.hid-tmff2 ];
        boot.kernelModules = [ "hid-tmff2" ];

        environment.systemPackages = [ pkgs.oversteer ];
        services.udev.packages = [ pkgs.oversteer ];
      };
    };
}
