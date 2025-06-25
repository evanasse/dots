#!/bin/sh

# The $NAME variable is passed from sketchybar and holds the name of
# the item invoking this script:
# https://felixkratz.github.io/SketchyBar/config/events#events-and-scripting

alias sketchybar=/run/current-system/sw/bin/sketchybar
bin_path_sketchybar="/run/current-system/sw/bin/sketchybar"

if [ $SENDER = "mlx_update_list" ]; then
  running_models=$(ps -x | grep -e 'uvx.*mlx_lm.server' | grep -v 'grep' | sed 's/.*--model \([^ ]*\).*$/\1/' | sed 's,^mlx-community/,,')
  amount_of_models=$(echo -n $running_models | wc -l | sed 's/[ ]*\([^ ]*\).*/\1/')

  if [ -z $amount_of_models ]; then
    echo "$(date) debug: no running models." >> /tmp/sketchybar.debug
    sketchybar --set "$NAME" icon.drawing=off label.drawing=off
  else
    sketchybar --set "$NAME" \
      label.drawing=on label="MLX ($amount_of_models)" \
      click_script="$bin_path_sketchybar --set $NAME popup.drawing=toggle" \
      popup.height=35 \
      popup.background.drawing=on \
      popup.background.corner_radius=6

    for model in $running_models; do
      sketchybar --add item $NAME.$model popup.$NAME --set $NAME.$model label="$model"
    done
  fi
fi
