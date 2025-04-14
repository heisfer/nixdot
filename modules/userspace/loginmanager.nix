{
  config,
  lib,
  pkgs,
  ...
}:
let

  inherit (lib.options) mkEnableOption mkPackageOption mkOption;
  inherit (lib.modules) mkIf;
  cfg = config.userspace.loginmanager;
in
{
  options.userspace.loginmanager = {
    enable = mkEnableOption "greetd";
    package = mkPackageOption pkgs [ "greetd" "greetd" ] { };
  };
  config = mkIf cfg.enable {
    services.greetd.enable = true;
    services.greetd.settings =
      let
        start = {
          command = "${lib.getExe config.programs.uwsm.package} start hyprland-uwsm.desktop > /dev/null"; # dev/null for no messages on the screen
          user = "heisfer";
        };
      in
      {
        initial_session = start;
        default_session = start;
      };
  };

}
