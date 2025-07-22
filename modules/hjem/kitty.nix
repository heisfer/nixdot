{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib.options) mkEnableOption mkPackageOption;
  inherit (lib.modules) mkIf;
  cfg = config.programs.kitty;
in
{
  options.programs.kitty = {
    enable = mkEnableOption "Kitty";

    package = mkPackageOption pkgs "kitty" { };
  };

  config = mkIf cfg.enable {

    environment.systemPackages = [ cfg.package ];

  };
}
