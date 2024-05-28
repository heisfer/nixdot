{
  lib,
  config,
  pkgs,
  ...
}:
let
  hyprctl = lib.getExe' config.wayland.windowManager.hyprland.package "hyprctl";
  hyprlock = lib.getExe' config.programs.hyprlock.package "hyprlock";
  lock = "${pkgs.systemd}/bin/loginctl lock-session";
in
{
  # screen idle
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        before_sleep_cmd = "${lock}";
        lock_cmd = "${hyprlock}";
      };

      listener = [
        {
          timeout = 300; # 5min
          onTimeout = "${hyprctl} dispatch dpms off";
          on-resume = "${hyprctl} dispatch dpms on";
        }
      ];
    };
  };
}
