{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (lib.dotmod.extra) appRunExe appRunExe';

  #uwsm wrapper function

  browser = appRunExe config.programs.firefox.package;
  terminal = appRunExe config.programs.wezterm.package;
  launcher = appRunExe pkgs.rofi-wayland + " -show drun -run-command \"app2unit -- {cmd}\"";
  rofi-rbw = appRunExe pkgs.rofi-rbw-wayland;
  hyprshot = appRunExe pkgs.hyprshot;
  hyprpicker = appRunExe pkgs.hyprpicker;
  swayosd = appRunExe' pkgs.swayosd "swayosd-client";
  swaync-client = appRunExe' config.services.swaync.package "swaync-client";
in
{

  imports = [
    # inputs.hyprland.nixosModules.default
    ./xdg.nix
  ];

  environment.systemPackages = [ pkgs.app2unit ];

  environment.sessionVariables = {
    UWSM_SILENT_START = 1;
    # uwsm integration
    APP2UNIT_SLICES = "a=app-graphical.slice b=background-graphical.slice s=session-graphical.slice";
    APP2UNIT_TYPE = "scope"; # programs.hyprnotify.enable = true;
  };

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
      "${appRunExe pkgs.local.hl-tricky-floaty}"
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
        "B, exec, ${appRunExe pkgs.rofi-bluetooth}"
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
        "L, exec, ${appRunExe config.programs.hyprlock.package}"
        "S, movetoworkspace, special:magic"
        "N, exec, ${appRunExe pkgs.rofi-network-manager}"
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
