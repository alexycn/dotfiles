#!/bin/bash
prgm="Rotation Lock Control"

status=$(systemctl --user is-active yoga-rotate)

if [[ "$status" == "active" ]]; then
    systemctl --user stop yoga-rotate
    systemctl --user disable yoga-rotate
    string="locked"
else
    systemctl --user enable --now yoga-rotate
    string="unlocked"
fi

# dunstify -i $icon -h string:x-dunst-stack-tag:bright -a "$prgm" "$string"
dunstify -h string:x-dunst-stack-tag:rotLock -a "$prgm" "$string"

