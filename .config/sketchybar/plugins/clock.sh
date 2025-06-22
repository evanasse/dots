#!/bin/sh

# The $NAME variable is passed from sketchybar and holds the name of
# the item invoking this script:
# https://felixkratz.github.io/SketchyBar/config/events#events-and-scripting

alias sketchybar=/run/current-system/sw/bin/sketchybar

sketchybar --set "$NAME" label="$(date '+%a %d %b %H:%M')"
