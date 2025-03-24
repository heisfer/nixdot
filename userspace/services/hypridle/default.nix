{
  lib,
  config,
  pkgs,
  ...
}:
let
  # Fucking hate this
  inherit (lib.dotmod.extra) uwsmGetExe uwsmGetExe';
  hyprlock = uwsmGetExe config.programs.hyprlock.package;
  pidof = uwsmGetExe' pkgs.procps "pidof";
  #in some point point to something else
  loginctl = (uwsmGetExe' pkgs.systemd "loginctl");
  systemctl = (uwsmGetExe' pkgs.systemd "systemctl");
  hyprctl = uwsmGetExe' config.programs.hyprland.package "hyprctl";

in
{
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "${pidof} ${hyprlock} || ${hyprlock}";
        before_sleep_cmd = "${loginctl} lock-session";
        after_sleep_cmd = "${hyprctl} dispatch dpms on";
      };
      listener = [
        {
          timeout = 60 * 2.5; # i wonder if it works
          on-timeout = "${loginctl} lock-session";
        }
        {
          timeout = 60 * 10; # set 10 min to suspend;
          on-timeout = "${systemctl} suspend";
        }
      ];
    };
  };
}
