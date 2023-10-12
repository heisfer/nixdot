#!/usr/bin/env bash
webdef=$(xdg-settings get default-web-browser | cut -f1 -d".")
options="Default Web: $webdef
"

theme=${1:-$HOME/.config/rofi/config.rasi}

selection=$(echo -e "${options}" | rofi -dmenu -config $theme -p "Setting")
case "${selection}" in
  "Default Web: $webdef")
    exec ~/.config/rofi/scripts/web.sh;;
esac
