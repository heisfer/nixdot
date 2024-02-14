{
  lib,
  pkgs,
  config,
  ...
}: let
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
    bind =
      [
        "$mod SHIFT, Q, exit,"
        "$mod, Q, killactive,"
        "$mod, F, fullscreen,"
        "$mod, T, togglefloating,"

        ",PRINT,exec,${lib.getExe pkgs.grim} -g \"$(${lib.getExe pkgs.slurp})\" - | ${pkgs.wl-clipboard}/bin/wl-copy -t image/png && notify-send 'Screenshot Copied to Clipboard'"
        "$mod ,PRINT,exec,grim -o $(hyprctl monitors -j | jq -r '.[] | select(.focused) | .name') - | wl-copy -t image/png && notify-send 'Screenshot Copied to Clipboard'"

        "$mod, RETURN, exec, ${lib.getExe config.programs.wezterm.package}"
        "$mod, W, exec, ${lib.getExe config.programs.firefox.package} -new-tab about:newtab"
        "$mod, M, exec, ${lib.getExe config.programs.rofi.package} -show drun -modi drun,run -display-drun \" Search\""
        "$mod, B, exec, ${lib.getExe pkgs.rofi-rbw-wayland}"
        "$mod SHIFT, B, exec, ${lib.getExe pkgs.rofi-bluetooth}"
        "$mod SHIFT, W, exec, ${lib.getExe config.programs.firefox.package}"

        #keep it same with helix
        "$mod, N, movefocus, l"
        "$mod, I, movefocus, r"
        "$mod, U, movefocus, u"
        "$mod, E, movefocus, d"

        "$mod SHIFT, N, movewindow, l"
        "$mod SHIFT, I, movewindow, r"
        "$mod SHIFT, U, movewindow, u"
        "$mod SHIFT, E, movewindow, d"

        "$mod, TAB, cyclenext,"
        "$mod, TAB, bringactivetotop,"

        "$mod, mouse_down, workspace, e+1"
        "$mod, mouse_up, workspace, e-1"
      ]
      ++ workspaces;
    bindm = [
      "$mod, mouse:272, movewindow"
      "$mod, mouse:273, resizewindow"
    ];
  };
}
