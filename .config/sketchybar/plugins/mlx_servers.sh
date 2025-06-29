#!/bin/zsh

# The $NAME variable is passed from sketchybar and holds the name of
# the item invoking this script:
# https://felixkratz.github.io/SketchyBar/config/events#events-and-scripting

bin_path_sketchybar="/run/current-system/sw/bin/sketchybar"
alias sketchybar=$bin_path_sketchybar

running_models=$(ps -x | grep -e 'uvx.*mlx_lm.server' | grep -v 'grep' | sed 's/.*--model \([^ ]*\).*--port \([^ ]*\).*$/\1:\2/' | sed 's,^mlx-community/,,')
echo "$(date) debug: running_models: $running_models" >> /tmp/sketchybar.debug
if [ -z $running_models ]; then
  amount_of_models=0
else
  amount_of_models=$(echo $running_models | wc -l | sed 's/[ ]*\([^ ]*\).*/\1/')
fi
echo "$(date) debug: amount_of_models: $amount_of_models" >> /tmp/sketchybar.debug

if [ $amount_of_models -eq 0 ]; then
  echo "$(date) debug: no running models." >> /tmp/sketchybar.debug
  sketchybar --set "$NAME" icon.drawing=off label.drawing=off
else
  sketchybar --set "$NAME" \
    label.drawing=on label="MLX ($amount_of_models)" \
    click_script="$bin_path_sketchybar --set $NAME popup.drawing=toggle" \
    popup.background.drawing=on \
    popup.background.corner_radius=6 \
    popup.align=right

    sketchybar --query $NAME | jq '.popup.items' | grep '"' | sed 's/[", ]//g' | xargs -I % sketchybar --remove popup.%

    echo $running_models | xargs -I % sketchybar --add item $NAME.% popup.$NAME --set $NAME.% label="%"
fi
