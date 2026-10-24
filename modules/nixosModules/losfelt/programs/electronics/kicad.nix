{
  flake.nixosModules.losfelt =
    { lib, config, pkgs, ... }:
    let
      inherit (lib) mkEnableOption mkOption types mkIf;
      cfg = config.losfelt.programs.electronics.kicad;
      masterCfg = config.losfelt.programs.electronics;

      kicadPackage = pkgs.kicad.override {
        with3d = cfg.with3d;
      };
    in
    {
      options.losfelt.programs.electronics.kicad = {
        enable = mkEnableOption "KiCad EDA suite" // { default = masterCfg.enable; } ;

        with3d = mkOption {
          type = types.bool;
          default = true;
          description = "Whether to install standard 3D model libraries for components.";
        };

        extraPackages = mkOption {
          type = types.listOf types.package;
          default = [ ];
          description = "Additional EDA or PCB utility packages.";
        };
      };

      config = mkIf cfg.enable {
        environment.systemPackages = [
          pkgs.gerbv
          kicadPackage
        ] ++ cfg.extraPackages;
      };
    };
}
