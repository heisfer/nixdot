{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib.options) mkEnableOption mkPackageOption;
  inherit (lib.modules) mkIf;
  cfg = config.programs.kdiskmark;
in
{
  options.programs.kdiskmark = {
    enable = mkEnableOption "kdiskmark";
    package = mkPackageOption pkgs "kdiskmark" { };
  };

  config = mkIf cfg.enable {
    services.dbus.packages = [ cfg.package ];
    environment.systemPackages = [ cfg.package ];
  };

}
