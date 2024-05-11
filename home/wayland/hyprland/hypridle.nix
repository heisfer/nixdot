{ lib, config, ... }:
let
  hyprctl = lib.getExe' config.wayland.windowManager.hyprland.package "hyprctl";
  hyprlock = lib.getExe' config.programs.hyprlock.package "hyprlock";
in
{
  # screen idle
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        after_sleep_cmd = "${hyprctl} dispatch dpms on";
        before_sleep_cmd = "${hyprlock}";
        lock_cmd = "${hyprlock}";
      };

      listener = [
        {
          timeout = 150; # 2.5 min
          onTimeout = "${hyprlock}";
        }
        {
          timeout = 300; # 5min
          onTimeout = "${hyprctl} dispatch dpms off";
          on-resume = "${hyprctl} dispatch dpms on";
        }
      ];
    };
  };
}
