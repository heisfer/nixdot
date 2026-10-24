{
  flake.nixosModules.losfelt = { lib, config, ... }: {
    options.losfelt.hardware.amd.enable = lib.mkEnableOption "amd";

    config = lib.mkIf config.losfelt.hardware.amd.enable {
      services.xserver.videoDriver = "amdgpu";
      hardware.graphics = {
        enable = true;
        enable32Bit = true;
      };

    };
  };
}
