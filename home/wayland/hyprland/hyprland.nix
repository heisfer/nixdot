{
  config,
  pkgs,
  lib,
  ...
}: {
  wayland.windowManager.hyprland.extraConfig = ''

    # Monitors
    monitor=DP-2,1920x1080@75,0x0,1
    monitor=eDP-1,1920x1200@60,0x1080,1
#    monitor=eDP-1,1920x1200@60,0x0,1

    # Auto start
    # exec-once = hyprpaper
    exec-once = waybar
    exec-once = keyctl link @u @s
    exec-once = xrandr --output DP-2 --primary
    exec-once = swww init
    #



    # For all categories, see https://wiki.hyprland.org/Configuring/Variables/
    device:at-translated-set-2-keyboard {
        kb_layout=us,ee
        kb_model=pc105
        kb_variant=colemak,
        kb_options=grp:alt_space_toggle
    }
    input {
        kb_layout = us
        kb_variant =
        kb_model =
        kb_options =
        kb_rules =

        follow_mouse = 1

        touchpad {
            natural_scroll = false
        }

        sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
    }

    general {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more

        # resize_on_border = true

        gaps_in = 5
        gaps_out = 20
        border_size = 2
        col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
        col.inactive_border = rgba(595959aa)

        layout = dwindle
    }

    decoration {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more

        rounding = 10
        blur {
            enabled = true
            size = 3
            passes = 1
            new_optimizations = true
        }




        drop_shadow = true
        shadow_range = 4
        shadow_render_power = 3
        col.shadow = rgba(1a1a1aee)
    }

    animations {
        enabled = yes
        bezier = wind, 0.05, 0.9, 0.1, 1.05
        bezier = winIn, 0.1, 1.1, 0.1, 1.1
        bezier = winOut, 0.3, -0.3, 0, 1
        bezier = liner, 1, 1, 1, 1
        animation = windows, 1, 6, wind, slide
        animation = windowsIn, 1, 6, winIn, slide
        animation = windowsOut, 1, 5, winOut, slide
        animation = windowsMove, 1, 5, wind, slide
        animation = border, 1, 1, liner
        animation = borderangle, 1, 30, liner, loop
        animation = fade, 1, 10, default
        animation = workspaces, 1, 5, wind
    }

    dwindle {
        # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
        pseudotile = true # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
        preserve_split = true # you probably want this
    }

    master {
        # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
        new_is_master = true
    }

    gestures {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more
        workspace_swipe = false
    }

    misc {
        disable_hyprland_logo = true
        disable_splash_rendering = true
    }

    # Example per-device config
    # See https://wiki.hyprland.org/Configuring/Keywords/#executing for more
    device:epic-mouse-v1 {
        sensitivity = -0.5
    }

    # Example windowrule v1
    # windowrule = float, ^(kitty)$
    # Example windowrule v2
    # windowrulev2 = float,class:^(kitty)$,title:^(kitty)$
    # See https://wiki.hyprland.org/Configuring/Window-Rules/ for more
    windowrulev2 = float,class:(eu.web-eid.),title:(Web eID)
    windowrulev2 = size 677 429, class:(eu.web-eid.),title:(Web eID)

    # See https://wiki.hyprland.org/Configuring/Keywords/ for more
    $mainMod = SUPER

    # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
    bind = $mainMod, RETURN, exec, ${lib.getExe config.programs.wezterm.package}
    bind = $mainMod, Q, killactive,
    bind = $mainMod, W, exec, ${lib.getExe config.programs.firefox.package} -new-tab about:newtab
    bind = $mainMod  SHIFT, W, exec, ${lib.getExe config.programs.firefox.package}
    bind = $mainMod, M, exit,
    bind = $mainMod, S, exec, ${lib.getExe config.programs.rofi.package} -show drun -modi drun,run -display-drun " Search"
    bind = $mainMod, B, exec, ${lib.getExe pkgs.rofi-bluetooth}
    bind = $mainMod, E, exec, ${lib.getExe pkgs.deepin.dde-file-manager}
    bind = $mainMod, V, togglefloating,
    bind=  $mainMod, F,fullscreen,
    bind = $mainMod, P, pseudo, # dwindle
    bind = $mainMod, J, togglesplit, # dwindle
    bind=  ,PRINT,exec,${lib.getExe pkgs.grim} -g "$(${lib.getExe pkgs.slurp})" - | ${pkgs.wl-clipboard}/bin/wl-copy -t image/png
    bind=  $mainMod,PRINT,exec,grim -o $(hyprctl monitors -j | jq -r '.[] | select(.focused) | .name') - | wl-copy -t image/png && notify-send 'Screenshot Copied to Clipboard'

    # Move focus with mainMod + arrow keys
    bind = $mainMod, left, movefocus, l
    bind = $mainMod, right, movefocus, r
    bind = $mainMod, up, movefocus, u
    bind = $mainMod, down, movefocus, d

    # Switch workspaces with mainMod + [0-9]
    bind = $mainMod, 1, workspace, 1
    bind = $mainMod, 2, workspace, 2
    bind = $mainMod, 3, workspace, 3
    bind = $mainMod, 4, workspace, 4
    bind = $mainMod, 5, workspace, 5
    bind = $mainMod, 6, workspace, 6
    bind = $mainMod, 7, workspace, 7
    bind = $mainMod, 8, workspace, 8
    bind = $mainMod, 9, workspace, 9
    bind = $mainMod, 0, workspace, 10

    # Move active window to a workspace with mainMod + SHIFT + [0-9]
    bind = $mainMod SHIFT, 1, movetoworkspace, 1
    bind = $mainMod SHIFT, 2, movetoworkspace, 2
    bind = $mainMod SHIFT, 3, movetoworkspace, 3
    bind = $mainMod SHIFT, 4, movetoworkspace, 4
    bind = $mainMod SHIFT, 5, movetoworkspace, 5
    bind = $mainMod SHIFT, 6, movetoworkspace, 6
    bind = $mainMod SHIFT, 7, movetoworkspace, 7
    bind = $mainMod SHIFT, 8, movetoworkspace, 8
    bind = $mainMod SHIFT, 9, movetoworkspace, 9
    bind = $mainMod SHIFT, 0, movetoworkspace, 10

    # ------[Function Keys]------
    bind=,XF86AudioMute,exec,~/.config/scripts/volume.sh mute
    bind=,XF86AudioRaiseVolume,exec,~/.config/scripts/volume.sh up
    bind=,XF86AudioLowerVolume,exec,~/.config/scripts/volume.sh down
    bind=,XF86AudioMicMute,exec,pactl set-source-mute @DEFAULT_SOURCE@ toggle
    bind=,XF86MonBrightnessDown,exec,brightnessctl set 5%-
    bind=,XF86MonBrightnessUp,exec,brightnessctl set +5%
    bind=,XF86AudioPlay,exec,playerctl play-pause
    bind=,XF86AudioNext,exec,playerctl next
    bind=,XF86AudioPrev,exec,playerctl previous

    # Scroll through existing workspaces with mainMod + scroll
    bind = $mainMod, mouse_down, workspace, e+1
    bind = $mainMod, mouse_up, workspace, e-1

    # Move/resize windows with mainMod + LMB/RMB and dragging
    bindm = $mainMod, mouse:272, movewindow
    bindm = $mainMod, mouse:273, resizewindow
    bind = $mainMod,Tab,bringactivetotop,
  '';
}
