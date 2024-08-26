{
  lib,
  pkgs,
  config,
  ...
}:
let
  swayosd = lib.getExe' pkgs.swayosd "swayosd-client";
  hyprshot = lib.getExe pkgs.hyprshot;
  workspaces = builtins.concatLists (
    builtins.genList (
      x:
      let
        ws =
          let
            c = (x + 1) / 10;
          in
          builtins.toString (x + 1 - (c * 10));
      in
      [
        "SUPER, ${ws}, workspace, ${toString (x + 1)}"
        "SUPER_SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
      ]
    ) 10
  );
in
{
  wayland.windowManager.hyprland.settings = {
    bind = [
      "SUPER_SHIFT, Q, exit,"
      "SUPER, Q, killactive,"
      "SUPER, W, exec, ${lib.getExe config.programs.firefox.package} -new-tab about:newtab"
      "SUPER_SHIFT, W, exec, ${lib.getExe config.programs.firefox.package}"
      "SUPER, F, fullscreen,"
      "SUPER, T, togglefloating,"

      "SUPER, RETURN, exec, ${lib.getExe' config.programs.wezterm.package "wezterm"}"

      "SUPER, H, movefocus, l"
      "SUPER, J, movefocus, u"
      "SUPER, K, movefocus, d"
      "SUPER, L, movefocus, r"

      "SUPER_SHIFT, H, movewindow, l"
      "SUPER_SHIFT, L, movewindow, r"
      "SUPER_SHIFT, J, movewindow, u"
      "SUPER_SHIFT, K, movewindow, d"

      "SUPER, B, exec, ${lib.getExe pkgs.rofi-bluetooth}"
      "SUPER, M, exec, ${lib.getExe config.programs.rofi.package} -show drun -modi drun,run -display-drun \" Search\""
      "SUPER, TAB, cyclenext,"
      "SUPER, TAB, bringactivetotop,"

      # I don't really want to save screenshots.... just for notification eye candy :)
      ", PRINT, exec, ${hyprshot} -m region -o /tmp/sswkjf"
      "SUPER, PRINT, exec, ${hyprshot} -m output -c -o /tmp/sswkjf" # -c for current output
      "SUPER_SHIFT, PRINT, exec, ${hyprshot} -m window -o /tmp/sswkjf"

      "SUPER, mouse_down, workspace, e+1"
      "SUPER, mouse_up, workspace, e-1"

      #function keys
      ", XF86AudioRaiseVolume, exec, ${swayosd} --output-volume raise"
      ", XF86AudioLowerVolume, exec, ${swayosd} --output-volume lower"
      ", XF86AudioMute, exec, ${swayosd} --output-volume mute-toggle"
      ", XF86MonBrightnessUp, exec, ${swayosd} --brightness raise"
      ", XF86MonBrightnessDown, exec, ${swayosd} --brightness lower"

    ] ++ workspaces;

    bindm = [
      "SUPER, mouse:272, movewindow"
      "SUPER, mouse:273, resizewindow"
    ];
  };
}
