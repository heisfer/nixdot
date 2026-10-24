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

      masterCfg = config.losfelt.programs.development;
      cfg = config.losfelt.programs.development.direnv;
    in
    {
      options.losfelt.programs.development.direnv.enable = mkEnableOption "direnv" // {
        default = masterCfg.enable;
      };

      config = (mkIf cfg.enable) {
        programs.direnv = {
          enable = true;
          silent = true;
          nix-direnv.enable = true;
        };

      };

    };
}
