{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (lib) getExe getExe';
  browser = getExe config.programs.firefox.package;
  terminal = getExe pkgs.wezterm;
  launcher = getExe pkgs.rofi-wayland + " -show drun";
  rofi-rbw = getExe pkgs.rofi-rbw-wayland;
  hyprshot = getExe pkgs.hyprshot;
  hyprpicker = getExe pkgs.hyprpicker;
  swayosd = getExe' pkgs.swayosd "swayosd-client";
in
{

  imports = [ inputs.hyprland.nixosModules.default ];

  programs.hyprland.enable = true;
  programs.hyprland.withUWSM = true;

  programs.hyprland.settings = {
    monitor = [
      "eDP-1, 1920x1200@60, 0x0, 1"
    ];
    misc = {
      disable_hyprland_logo = true;
      disable_splash_rendering = true;
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
        "B, exec, ${lib.getExe pkgs.rofi-bluetooth}"
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
        "L, exec, ${lib.getExe config.programs.hyprlock.package}"
        "S, movetoworkspace, special:magic"
        "P, exec, ${hyprpicker}"
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
