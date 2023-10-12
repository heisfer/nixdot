#!/usr/bin/env bash
options=" Search
 Package Search
 Network
 Bluetooth
 SSH
 Bitwarden
 Settings
⏻ Power
 File"
theme=${1:-$HOME/.config/rofi/config.rasi}
selection=$(echo -e "${options}" | rofi -dmenu -config $theme -p "Menu" -fixed-num-lines 5) 
case "${selection}" in
  " Search")
    rofi -show drun -modi drun,run -display-drun " Search";;
  " Package Search")
    sh ~/.config/rofi/menu/nix.sh;;
  " Network")
    exec ~/.config/rofi/menu/rofi-network-manager.sh;;
  " Bluetooth")
    exec ~/.config/rofi/menu/bt.sh;;
  " Bitwarden")
    rofi-bluetooth;;
  " SSH")
    exec ~/.config/rofi/menu/ssh.sh "SSH";;
  " Settings")
    exec ~/.config/rofi/menu/settings.sh;;
  "⏻ Power")
#    exec ~/.config/rofi/powermenu/powermenu.sh;;
    exec wlogout;;
  " File")
    exec rofi -show filebrowser;;
esac
