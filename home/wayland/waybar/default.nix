{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  home.file = {
    waybar-rose-pine = {
      target = ".config/waybar/rose-pine.css";
      source = "${inputs.waybar-rose-pine}/rose-pine.css";
    };
  };
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    systemd.target = "hyprland-session.target";
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        modules-left = ["clock" "hyprland/language" "hyprland/workspaces"];
        modules-center = ["hyprland/window"];
        modules-right = ["tray" "network" "battery" "pulseaudio" "backlight"];

        "hyprland/workspaces" = {
          format = "{}";
          max-length = 40;
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
        "tray" = {
          icon-size = 18;
          spacing = 10;
        };
        "blacklight" = {
          device = "amd_backlight";
          format = "{icon} {percent}";
          format-icons = [
            "󰃞"
            "󰃟"
            "󰃠"
          ];
          on-scroll-up = "${lib.getExe' config.services.swayosd.package "swayosd-client"} --brightness 1";
          on-scroll-down = "${lib.getExe' config.services.swayosd.package "swayosd-client"} --brightness -1";
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
        "pulseaudio" = {
          format = "{icon} {volume}%";
          format-muted = "";
          on-click = "${lib.getExe pkgs.pavucontrol}";
          on-scroll-up = "${lib.getExe' config.services.swayosd.package "swayosd-client"} --output-volume 1";
          on-scroll-down = "${lib.getExe' config.services.swayosd.package "swayosd-client"} --output-volume -1";
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
        "network" = {
          format-wifi = " {signalStrength}%";
          format-ethernet = "󰇧 ONLINE";
          tooltip-format = "{essid} - {ifname} via {gwaddr}";
          format-linked = "{ifname} (No IP) ";
          format-disconnected = "󰇨 OFFLINE";
          format-alt = "{ifname} ={essid} {ipaddr}/{cidr}";
          on-click-right = "~/.config/rofi/bin/network";
        };
      };
    };

    style = builtins.readFile ./style.css;
  };
}
