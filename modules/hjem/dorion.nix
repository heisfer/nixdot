{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib.options) mkEnableOption mkPackageOption;
  inherit (lib.modules) mkIf;
  cfg = config.programs.dorion;
in
{
  options.programs.dorion = {
    enable = mkEnableOption "dorion";
    package = mkPackageOption pkgs "dorion" { };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
  };

}
