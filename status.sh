#!/bin/bash

timestamp=$(date +'%Y-%m-%d %l:%M:%S %p')
volume=$(awk -F"[][]" '/Mono:/ { print $2 }' <(amixer sget Master))
if $(amixer sget Master | grep -q off); then
    volume="mute"
fi

echo "vol $volume | $timestamp"
