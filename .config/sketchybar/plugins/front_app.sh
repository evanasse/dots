#!/bin/zsh

# Some events send additional information specific to the event in the $INFO
# variable. E.g. the front_app_switched event sends the name of the newly
# focused application in the $INFO variable:
# https://felixkratz.github.io/SketchyBar/config/events#events-and-scripting

if [ "$SENDER" = "front_app_switched" ]; then
  sketchybar --set "$NAME" label="$INFO"
elif [ "$SENDER" = "aerospace_workspace_change" ]; then
  if [ $(aerospace list-workspaces --monitor focused --empty | grep $FOCUSED_WORKSPACE) ]; then
    sketchybar --set "$NAME" label.drawing=off
  else
    sketchybar --set "$NAME" label.drawing=on
  fi
fi
