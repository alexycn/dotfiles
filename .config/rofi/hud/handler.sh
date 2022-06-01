#!/bin/bash

sPath=$(dirname "$0")

$sPath/hud.sh | {
    while IFS= read -r line
    do
        type=$(echo $line | jq '.data')
        if [[ "$type" == "\"launcher\"" ]]; then
            killall rofi
            $sPath/../launchers/launcher.sh
        elif [[ "$type" == "\"powermenu\"" ]]; then
            killall rofi
            $sPath/../powermenu/powermenu.sh
        fi
    done
}
