{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib.options) mkEnableOption mkPackageOption;
  inherit (lib.modules) mkIf;
  inherit (lib.meta) getExe;
  cfg = config.services.arrpc;
in
{

  options.services.arrpc = {
    enable = mkEnableOption "arrpc";
    package = mkPackageOption pkgs "arrpc" { };
  };
  config = mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
    systemd = {
      packages = [ cfg.package ];
      user.services.arRPC = {
        description = "Discord Rich Presence for browsers, and some custom clients";
        partOf = [ "graphical-session.target" ];
        serviceConfig = {
          ExecStart = getExe cfg.package;
          Restart = "always";
        };
        wantedBy = [ "graphical-session.target" ];
      };
    };
  };
}
