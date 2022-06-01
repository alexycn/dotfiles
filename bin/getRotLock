#!/bin/bash

status=$(systemctl --user is-active yoga-rotate)

if [[ "$status" == "active" ]]; then
    echo "unlocked"
else
    echo "locked"
fi
