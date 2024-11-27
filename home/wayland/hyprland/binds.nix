{
  config,
  pkgs,
  lib,
  ...
}:
let
  terminal = lib.getExe config.programs.kitty.package;
  browser = lib.getExe config.programs.firefox.package;
  launcher = lib.getExe config.programs.rofi.package + " -show drun";
  swayosd = lib.getExe' config.services.swayosd.package "swayosd-client";
  hyprshot = lib.getExe pkgs.hyprshot;
in
{
  wayland.windowManager.hyprland.settings = {
    "$mod" = "SUPER";
    bind =
      # Just Super key
      map (x: "SUPER, " + x) [
        "Q, killactive,"
        "W, exec, ${browser}"
        "RETURN, exec, ${terminal}"
        "M, exec, ${launcher}"
        "F, fullscreen,"
        "PRINT, exec, ${hyprshot} -m output -c -o /tmp/sswkjf" # -c for current output

      ]
      # No mod binds
      ++ [
        ", PRINT, exec, ${hyprshot} -m region -o /tmp/sswkjf"
      ]
      # Super + Shift keybinds
      ++ map (x: "SUPER SHIFT, " + x) [
        "Q, exit,"
      ]
      # WorkSpaces
      ++ map (ws: "SUPER, ${toString ws}, workspace, ${toString ws}") (lib.lists.range 1 9)
      ++ map (ws: "SUPER SHIFT, ${toString ws}, movetoworkspace, ${toString ws}") (lib.lists.range 1 9);

    bindel = [
      ", XF86AudioRaiseVolume, exec, ${swayosd} --output-volume raise"
      ", XF86AudioLowerVolume, exec, ${swayosd} --output-volume lower"
      ", XF86AudioMute, exec, ${swayosd} --output-volume mute-toggle"
      ", XF86MonBrightnessUp, exec, ${swayosd} --brightness raise"
      ", XF86MonBrightnessDown, exec, ${swayosd} --brightness lower"
    ];

  };
}
