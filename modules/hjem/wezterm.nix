{
  config,
  lib,
  pkgs,
  ...
}:
let

  inherit (lib.options) mkEnableOption mkPackageOption mkOption;
  inherit (lib.types)
    nullOr
    listOf
    str
    lines
    ;
  inherit (lib.modules) mkIf mkMerge;
  inherit (lib.lists) forEach;
  cfg = config.programs.wezterm;
in
{
  options.programs.wezterm = {
    enable = mkEnableOption "wezterm";
    package = mkPackageOption pkgs "wezterm" { };
    users = mkOption {
      type = listOf str;
      default = config.shitfest.users;
    };
    settings = mkOption {
      type = nullOr lines;
      default = null;
    };
  };
  config = mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
    hjem.users = mkMerge (
      forEach cfg.users (user: {
        ${user}.files.".config/wezterm/wezterm.lua" = mkIf (cfg.settings != null) {
          text = cfg.settings;
        };
      })
    );
  };
}
