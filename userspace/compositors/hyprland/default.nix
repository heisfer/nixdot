{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (lib.dotmod.extra) uwsmGetExe uwsmGetExe';

  #uwsm wrapper function

  browser = uwsmGetExe config.programs.firefox.package;
  terminal = uwsmGetExe config.programs.ghostty.package;
  launcher = uwsmGetExe pkgs.rofi-wayland + " -show drun -run-command \"uwsm-app -- {cmd}\"";
  rofi-rbw = uwsmGetExe pkgs.rofi-rbw-wayland;
  hyprshot = uwsmGetExe pkgs.hyprshot;
  hyprpicker = uwsmGetExe pkgs.hyprpicker;
  swayosd = uwsmGetExe' pkgs.swayosd "swayosd-client";
  swaync-client = uwsmGetExe' config.services.swaync.package "swaync-client";
in
{

  imports = [
    # inputs.hyprland.nixosModules.default
    ./xdg.nix
  ];

  # programs.hyprnotify.enable = true;

  programs.hyprland.enable = true;
  programs.hyprland.withUWSM = true;
  programs.hyprland.settings = {

    "$base" = "0xff191724";
    "$surface" = "0xff1f1d2e";
    "$overlay" = "0xff26233a";
    "$muted" = "0xff6e6a86";
    "$subtle" = "0xff908caa";
    "$text" = "0xffe0def4";
    "$love" = "0xffeb6f92";
    "$gold" = "0xfff6c177";
    "$rose" = "0xffebbcba";
    "$pine" = "0xff31748f";
    "$foam" = "0xff9ccfd8";
    "$iris" = "0xffc4a7e7";
    "$highlightLow" = "0xff21202e";
    "$highlightMed" = "0xff403d52";
    "$highlightHigh" = "0xff524f67";

    env = [
      "GDK_SCALE,1"
      "QT_QPA_PLATFORM,wayland;xcb"
      # "QT_QPA_PLATFORMTHEME,qt6ct" # managed by nix
      "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
      "QT_AUTO_SCREEN_SCALE_FACTOR,1"
    ];
    monitor = [
      "eDP-1, 1920x1200@60, 0x0, 1"
    ];

    windowrulev2 = [
      "noblur, class:firefox-aurora"
      "float, class:com.saivert.pwvucontrol"
      "size 850 450, class:com.saivert.pwvucontrol"
      "move 50% 20%, class:com.saivert.pwvucontrol"
    ];
    exec-once = [
      "uwsm finalize"
      "${uwsmGetExe pkgs.local.hl-tricky-floaty}"
    ];
    general = {
      "col.active_border" = "$rose";
      "col.inactive_border" = "$muted";
    };
    misc = {
      disable_hyprland_logo = true;
      disable_splash_rendering = true;
      font_family = "monospace";
    };
    input = {
      kb_layout = "us,ee";
      kb_options = "caps:escape,grp:alt_space_toggle";
    };
    "$mod" = "SUPER";
    bind =
      map (x: "$mod, " + x) [
        "Q, killactive,"
        "W, exec, ${browser}"
        "RETURN, exec, ${terminal}"
        "M, exec, ${launcher}"
        "P, exec, ${rofi-rbw}"
        "B, exec, ${uwsmGetExe pkgs.rofi-bluetooth}"
        "N, exec, ${swaync-client} --toggle-panel"
        "F, fullscreen,"
        "PRINT, exec, ${hyprshot} -m output -m active -c -o /tmp/sswkjf" # -c for current output
        "S, togglespecialworkspace, magic"

        "H, movefocus, l"
        "J, movefocus, d"
        "K, movefocus, u"
        "L, movefocus, r"
        "T, togglefloating,"

        # MOUSE
        "mouse_down, workspace, e+1"
        "mouse_up, workspace, e-1"
      ]
      # Super + Shift keybinds
      ++ map (x: "$mod SHIFT, " + x) [
        "Q, exit,"
        "L, exec, ${uwsmGetExe config.programs.hyprlock.package}"
        "S, movetoworkspace, special:magic"
        "N, exec, ${uwsmGetExe pkgs.rofi-network-manager}"
        "P, exec, ${hyprpicker}"
        "PRINT, exec, ${hyprshot} -m window -m active -c -o /tmp/sswkjf"
      ]
      # NO MOD
      ++ [
        ", PRINT, exec, ${hyprshot} -m region -o /tmp/sswkjf"
      ]

      # WorkSpaces
      ++ map (ws: "$mod, ${toString ws}, workspace, ${toString ws}") (lib.lists.range 1 9)
      ++ map (ws: "$mod SHIFT, ${toString ws}, movetoworkspace, ${toString ws}") (lib.lists.range 1 9);

    bindel = [
      ", XF86AudioRaiseVolume, exec, ${swayosd} --output-volume raise"
      ", XF86AudioLowerVolume, exec, ${swayosd} --output-volume lower"
      ", XF86AudioMute, exec, ${swayosd} --output-volume mute-toggle"
      ", XF86MonBrightnessUp, exec, ${swayosd} --brightness raise"
      ", XF86MonBrightnessDown, exec, ${swayosd} --brightness lower"
    ];
    bindm = [
      "SUPER, mouse:272, movewindow"
      "SUPER, mouse:273, resizewindow"
    ];

  };
}
