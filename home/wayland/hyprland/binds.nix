{
  lib,
  pkgs,
  config,
  ...
}: let
  swayosd = lib.getExe' pkgs.swayosd "swayosd-client";
  workspaces = builtins.concatLists (builtins.genList (
      x: let
        ws = let
          c = (x + 1) / 10;
        in
          builtins.toString (x + 1 - (c * 10));
      in [
        "$mod, ${ws}, workspace, ${toString (x + 1)}"
        "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
      ]
    )
    10);
in {
  wayland.windowManager.hyprland.settings = {
    "$mod" = "SUPER";
    bind =
      [
        "$mod SHIFT, Q, exit,"
        "$mod, Q, killactive,"
        "$mod, F, fullscreen,"
        "$mod, T, togglefloating,"

        ",PRINT,exec,${lib.getExe pkgs.grim} -g \"$(${lib.getExe pkgs.slurp})\" - | ${lib.getExe' pkgs.wl-clipboard "wl-copy"} -t image/png && ${lib.getExe' pkgs.libnotify "notify-send"} 'Screenshot Copied to Clipboard'"

        "$mod ,PRINT,exec,${lib.getExe pkgs.grim} -o $(hyprctl monitors -j | ${lib.getExe pkgs.jq} -r '.[] | select(.focused) | .name') - | ${lib.getExe' pkgs.wl-clipboard "wl-copy"} -t image/png && ${lib.getExe' pkgs.libnotify "notify-send"} 'Screenshot Copied to Clipboard'"

        "$mod, RETURN, exec, ${lib.getExe config.programs.foot.package}"
        "$mod, W, exec, ${lib.getExe config.programs.firefox.package} -new-tab about:newtab"
        "$mod, M, exec, ${lib.getExe config.programs.rofi.package} -show drun -modi drun,run -display-drun \" Search\""
        "$mod, B, exec, ${lib.getExe pkgs.rofi-rbw-wayland}"
        "$mod SHIFT, B, exec, ${lib.getExe pkgs.rofi-bluetooth}"
        "$mod SHIFT, W, exec, ${lib.getExe config.programs.firefox.package}"

        #keep it same with helix
        "$mod, H, movefocus, l"
        "$mod, L, movefocus, r"
        "$mod, J, movefocus, u"
        "$mod, K, movefocus, d"

        "$mod SHIFT, H, movewindow, l"
        "$mod SHIFT, L, movewindow, r"
        "$mod SHIFT, J, movewindow, u"
        "$mod SHIFT, K, movewindow, d"

        "$mod, TAB, cyclenext,"
        "$mod, TAB, bringactivetotop,"

        "$mod, mouse_down, workspace, e+1"
        "$mod, mouse_up, workspace, e-1"

        #function keys
        ", XF86AudioRaiseVolume, exec, ${swayosd} --output-volume raise"
        ", XF86AudioLowerVolume, exec, ${swayosd} --output-volume lower"
        ", XF86AudioMute, exec, ${swayosd} --output-volume mute-toggle"
      ]
      ++ workspaces;
    bindm = [
      "$mod, mouse:272, movewindow"
      "$mod, mouse:273, resizewindow"
    ];
  };
}
