{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (lib.meta) getExe getExe';
in
{

  programs.waybar.enable = true;
  programs.waybar.style = ./style.css;
  programs.waybar.settings = {
    layer = "top";
    position = "top";
    modules-left = [
      "clock"
      "hyprland/language"
      "niri/language"
      "hyprland/workspaces"
      "niri/workspaces"
    ];
    modules-center = [
      "mpris"
    ];
    modules-right = [
      "custom/notification"
      "tray"
      "network"
      "battery"
      "pulseaudio"
      "backlight"
    ];

    mpris = {
      format = "{status_icon} {artist} - {title}";
      title-len = 60;
      ignored-players = [ "firefox" ];
      status-icons = {
        playing = "";
        paused = "";
      };
    };

    "hyprland/workspaces" = {
      disable-scroll = true;
      on-click = "activate";
    };
    "hyprland/language" = {
      format = " {}";
      format-en = "US";
      format-et = "EE";
      format-no = "NO";
    };
    "niri/language" = {
      format = " {}";
      format-en = "US";
      format-et = "EE";
      format-no = "NO";
    };
    "idle_inhibitor" = {
      format = "{icon}";
      format-icons = {
        activated = "";
        deactivated = "";
      };
    };
    "tray" = {
      icon-size = 18;
      spacing = 10;
    };
    "backlight" = {
      device = "amd_backlight";
      format = "{icon} {percent}%";
      format-icons = [
        "󰃞"
        "󰃟"
        "󰃠"
      ];
      on-scroll-up = "${getExe' config.services.swayosd.package "swayosd-client"} --brightness raise";
      on-scroll-down = "${getExe' config.services.swayosd.package "swayosd-client"} --brightness lower";
      min-length = 6;
    };
    "battery" = {
      states = {
        good = 80;
        warning = 30;
        critical = 20;
      };
      format = "{icon} {capacity}%";
      format-charging = " {capacity}%";
      format-plugged = " {capacity}%";
      format-alt = "{time} {icon}";
      format-icons = [
        "󰂎"
        "󰁺"
        "󰁻"
        "󰁼"
        "󰁽"
        "󰁾"
        "󰁿"
        "󰂀"
        "󰂁"
        "󰂂"
        "󱈑"
      ];
    };
    clock = {
      format = " {:%H:%M  %d/%m}";
      tooltip-format = "{calendar}";
    };
    "pulseaudio" = {
      format = "{icon} {volume}%";
      format-muted = "";
      on-click = "${getExe pkgs.pwvucontrol}";
      on-scroll-up = "${getExe' config.services.swayosd.package "swayosd-client"} --output-volume 1";
      on-scroll-down = "${getExe' config.services.swayosd.package "swayosd-client"} --output-volume -1";
      format-icons = {
        headphone = "";
        hands-free = "";
        headset = "";
        phone = "";
        portable = "";
        car = "";
        default = [
          ""
          ""
          ""
        ];
      };
    };

    "custom/notification" = {
      tooltip = false;
      format = "{icon}";
      format-icons = {
        notification = "<span foreground='red'><sup></sup></span>";
        none = "";
        dnd-notification = "<span foreground='red'><sup></sup></span>";
        dnd-none = "";
        inhibited-notification = "<span foreground='red'><sup></sup></span>";
        inhibited-none = "";
        dnd-inhibited-notification = "<span foreground='red'><sup></sup></span>";
        dnd-inhibited-none = "";
      };
      return-type = "json";
      exec = "${getExe' config.services.swaync.package "swaync-client"} -swb";
      on-click = "${getExe' config.services.swaync.package "swaync-client"} -t -sw";
      on-click-right = "${getExe' config.services.swaync.package "swaync-client"} -d -sw";
      escape = true;
    };

    "network" = {
      format-wifi = " {signalStrength}%";
      format-ethernet = "󰇧 ONLINE";
      tooltip-format = "{essid} - {ifname} via {gwaddr}";
      format-linked = "{ifname} (No IP) 󰈂";
      format-disconnected = "󰇨 OFFLINE";
      format-alt = "{ifname} ={essid} {ipaddr}/{cidr}";
      # on-click-right = "~/.config/rofi/bin/network";
    };
  };
}
