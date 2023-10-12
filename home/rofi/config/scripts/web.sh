#!/bin/bash
current=$(xdg-settings get default-web-browser)

if [[ $current = "chromium.desktop" ]]
then
  xdg-settings set default-web-browser firefoxdeveloperedition.desktop
else
  xdg-settings set default-web-browser chromium.desktop
fi

new=$(xdg-settings get default-web-browser | cut -f1 -d".") 
notify-send "Changed default browser: $new"
