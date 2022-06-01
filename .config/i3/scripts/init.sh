#!/bin/bash

"$HOME"/.config/i3/scripts/rldUI.sh

launch=( 
    "dunst" 
    "unclutter"
)

for t in ${launch[@]}; do
    "$t" &
done
