{
  flake.nixosModules.losfelt =
    { config, lib, ... }:
    let
      cfg = config.losfelt.programs.steam;
      inherit (lib) mkEnableOption mkIf;
    in
    {
      options.losfelt.programs.steam.enable = mkEnableOption "Steam";

      config = mkIf cfg.enable {
        programs.steam = {
          enable = true;
        };

        programs.gamescope = {
          enable = true;
          capSysNice = true;
        };
      };

    };
}
