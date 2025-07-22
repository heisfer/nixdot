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
    default = {
      hyprland.enable = mkEnableOption "hyprland";
      niri.enable = mkEnableOption "niri";
    };
  };
  config =
    let
      defaultOptions = [
        cfg.default.hyprland.enable
        cfg.default.niri.enable
      ];
      trueOptions = builtins.length (builtins.filter (x: x) defaultOptions);
    in
    mkIf cfg.enable {
      assertions = [
        {
          assertation = trueOptions <= 1;
          message = "Only one can be default option in LoginManager";
        }
      ];
      services.greetd.enable = true;
      services.greetd.settings =
        let
          start = {
            command = "${lib.getExe config.programs.uwsm.package} start niri-uwsm.desktop > /dev/null"; # dev/null for no messages on the screen
            user = config.userspace.defaultUser;
          };
        in
        {
          initial_session = start;
          default_session = start;
        };
    };

}
