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

      cfg = config.losfelt.programs.floorp;
    in
    {
      options.losfelt.programs.floorp.enable = mkEnableOption "floorp";

      config = mkIf cfg.enable {
        environment.systemPackages = [ pkgs.floorp ];
      };
    };
}
