#!/usr/bin/env bash

FILTER='in-use,ssid,rate,security,bars'
PID="Astolfo"

function rescan () {
    rofi -e "Rescanning wifi list for 5sec" &
    PID=$!
    $(nmcli device wifi rescan)
    sleep 5
}

function get_wireless() {
    rescan
    kill -9 $PID
    RETURN=`nmcli -f "$FILTER" device wifi list`
    echo "$RETURN"
}


RETURN=`get_wireless`
spacer="----------------------------"
CURRENT="Disconnect: <NAME>"
rescan="Rescan wireless connections"
networkInfo="Network info"
wifion="Turn Off wifi"
rofimenu="${RETURN}\n${spacer}\n${CURRENT}\n${rescan}\n${networkInfo}\n${wifion}"
SELECTED=$(echo -e "$rofimenu" | rofi -dmenu   -p "test")

echo "${SELECTED}"