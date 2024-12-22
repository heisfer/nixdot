{ config, lib, ... }:
let
  terminal = lib.getExe config.programs.kitty.package;
  browser = lib.getExe config.programs.firefox.package;
  launcher = lib.getExe config.programs.rofi.package + " -show drun";
  swayosd = lib.getExe' config.services.swayosd.package "swayosd-client";
in
{
  wayland.windowManager.river.settings = {
    map = {
      normal = {
        "Super+Shift Q" = "exit";
        "Super Q" = "close";
        "Super Return" = "spawn ${terminal}";
        "Super W" = "spawn ${browser}";
        "Super Space" = "toggle-float";
        "Super F" = "toggle-fullscreen";
        "Super M" = "spawn '${launcher}'";

        "None XF86AudioRaiseVolume" = "spawn '${swayosd} --output-volume raise'";
        "None XF86AudioLowerVolume" = "spawn '${swayosd} --output-volume lower'";
        "None XF86AudioMute" = "spawn '${swayosd} --output-volume mute-toggle'";
        "None XF86MonBrightnessUp" = "spawn '${swayosd} --brightness raise'";
        "None XF86MonBrightnessDown" = "spawn '${swayosd} --brightness lower'";

      };
    };
    map-pointer = {
      normal = {
        "Super BTN_LEFT" = "move-view";
        "Super BTN_RIGHT" = "resize-view";
        "Super BTN_MIDDLE" = "toggle-float";
      };
    };
  };
  wayland.windowManager.river.extraConfig = ''
    for i in $(seq 1 9)
    do
        tags=$((1 << ($i - 1)))

        # Super+[1-9] to focus tag [0-8]
        riverctl map normal Super $i set-focused-tags $tags

        # Super+Shift+[1-9] to tag focused view with tag [0-8]
        riverctl map normal Super+Shift $i set-view-tags $tags

        # Super+Control+[1-9] to toggle focus of tag [0-8]
        riverctl map normal Super+Control $i toggle-focused-tags $tags

        # Super+Shift+Control+[1-9] to toggle tag [0-8] of focused view
        riverctl map normal Super+Shift+Control $i toggle-view-tags $tags
    done

  '';
}
