{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (lib.options) mkEnableOption mkPackageOption mkOption;
  inherit (lib.modules) mkIf;
  inherit (lib.types) lines;
  cfg = config.services.hyprpaper;
in
{
  options.services.hyprpaper = {
    enable = mkEnableOption "hyprpaper";
    package = mkPackageOption pkgs "hyprpaper" { };
    settings = mkOption {
      type = lines;
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
    environment.etc."xdg/hypr/hyprpaper.conf".text = cfg.settings;
    systemd = {
      packages = [ cfg.package ];
      user.services.hyprpaper.wantedBy = [ "graphical-session.target" ];
    };
  };

}
