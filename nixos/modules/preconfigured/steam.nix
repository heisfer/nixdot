{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.preconfigured.steam;
in
{
  options = {
    preconfigured.steam = {
      enable = lib.mkEnableOption "steam";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.steam = {
      enable = true;
      protontricks.enable = true;
      extraCompatPackages = [
        pkgs.proton-ge-bin
      ];
    };
  };
}
