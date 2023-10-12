#!/usr/bin/env bash
options="username@host"

selection=$(echo -e "${options}" | rofi -dmenu -p "Menu") 
wezterm ssh $selection
