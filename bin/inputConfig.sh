#!/bin/bash
# Script intended to run at Xorg server startup to configure all needed input configuration options
# Will setup touch screen, touchpad, mouse, and keyboard debounce

# Keyboard debounce
xkbset bo 20
xkbset exp =bo

# Reading from xinput and configuring needed properties
xinput | while read -r m; do
    id=$(echo "$m" | cut -d"=" -f2 | cut -d"[" -f1)
    isM=$(xinput list-props $id | grep "Accel" -c)
    if [ $isM == 0 ]; then
        continue
    fi
    xinput list $id | awk 'NR==1'
    xinput set-prop $id 'libinput Tapping Enabled' 1
    xinput set-prop $id 'libinput Accel Speed' 1
    xinput set-prop $id 'libinput Accel Profile Enabled' 0, 1
    if [ $(echo "$m" | grep -e "Mouse" -e "mouse" -c) == 0 ]; then
        xinput set-prop $id 'libinput Natural Scrolling Enabled' 1
    else
        xinput set-prop $id 'libinput Natural Scrolling Enabled' 0
    fi
done 2> /dev/null
