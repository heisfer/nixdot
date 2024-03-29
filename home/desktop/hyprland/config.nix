{
  config,
  pkgs,
  lib,
  ...
}: {
  wayland.windowManager.hyprland.settings = {
    env = [
      "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
    ];
    monitor = [
      "DP-2,1920x1080@75,0x0,1" # external monitor
      "eDP-1,1920x1200@60,0x1080,1" # laptop monitor
    ];

    exec-once = [
      "${lib.getExe' config.programs.ags.package "ags"} -b hypr" #might replace this in the future
      "${lib.getExe pkgs.xorg.xrandr} --output DP-2 --primary" #just for games
      "${lib.getExe pkgs.swww} init"
    ];

    input = {
      kb_layout = "us";
      kb_variant = "colemak_dh_wide_iso";
      kb_options = "caps:swapescape";
    };
    general = {
      "col.active_border" = "$rose";
      "col.inactive_border" = "$muted";
      layout = "drindle";
    };

    decoration = {
      blur = {
        enabled = true;
        size = 3;
        passes = 2;
      };

      drop_shadow = true;
      shadow_range = 4;
      shadow_render_power = 3;
      "col.shadow" = "$base";
    };

    animations = {
      enabled = true;

      bezier = [
        "myBezier, 0.05, 0.9, 0.1, 1.05"
      ];

      animation = [
        "windows, 1, 7, myBezier"
        "windowsOut, 1, 7, default, popin 80%"
        "border, 1, 10, default"
        "borderangle, 1, 8, default"
        "fade, 1, 7, default"
        "workspaces, 1, 6, default"
      ];
    };

    dwindle = {
      pseudotile = true;
      preserve_split = true;
    };

    master = {
      new_is_master = true;
    };

    gestures = {
      workspace_swipe = true;
    };

    misc = {
      disable_hyprland_logo = true;
      force_default_wallpaper = 0;
      vrr = 1;
    };

    windowrulev2 = [
      "float,class:(eu.web-eid.),title:(Web eID)"
      "size 677 429, class:(eu.web-eid.),title:(Web eID)"
    ];

    "$mod" = "SUPER";
  };
}
