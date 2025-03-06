{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (lib.options) mkEnableOption mkPackageOption;
  inherit (lib.modules) mkIf;
  cfg = config.programs.hyprnotify;
in
{
  options.programs.hyprnotify = {
    enable = mkEnableOption "hyprnotify";
    package = mkPackageOption pkgs "hyprnotify" { };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
    programs.hyprland.settings.exec-once = [ (lib.getExe cfg.package) ];
  };

}
