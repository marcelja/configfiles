#!/bin/bash

timestamp=$(date +'%Y-%m-%d %l:%M:%S %p')
volume=$(pulsemixer --get-volume | cut -d" " -f1)
if [[ $(pulsemixer --get-mute) == "1" ]]; then
    volume="mute"
fi
mic=""
if swaymsg -t get_tree | grep "Sharing Indicator" -q; then
    mic="FF mic | "
fi

echo "$mic vol $volume | $timestamp"
