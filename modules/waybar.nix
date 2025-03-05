{
  lib,
  config,
  pkgs,
  ...
}:
let
  ## most of the stuff is migrated from home-manager repo
  inherit (lib) isStorePath;
  inherit (lib.options) mkOption;
  inherit (lib.modules) mkIf;
  inherit (lib.types)
    lines
    nullOr
    oneOf
    path
    ;
  cfg = config.programs.waybar;

  jsonFormat = pkgs.formats.json { };
in
{

  options.programs.waybar = {
    settings = mkOption {
      type = jsonFormat.type;
      default = { };
    };
    style = mkOption {
      default = null;
      type = nullOr (oneOf [
        lines
        path
      ]);
    };

  };

  config = mkIf cfg.enable {

    #waybar also reads in /etc/xdg/waybar/
    environment.etc."xdg/waybar/style.css" = mkIf (cfg.style != null) {
      source =
        if builtins.isPath cfg.style || isStorePath cfg.style then
          cfg.style
        else
          pkgs.writeText "xdg/waybar/style.css" cfg.style;
    };
    environment.etc."xdg/waybar/config.jsonc" = mkIf (cfg.settings != { }) {
      source = jsonFormat.generate "waybar-config" cfg.settings;
    };

  };

}
