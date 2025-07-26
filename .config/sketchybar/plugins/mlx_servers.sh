#!/bin/zsh

# The $NAME variable is passed from sketchybar and holds the name of
# the item invoking this script:
# https://felixkratz.github.io/SketchyBar/config/events#events-and-scripting

bin_path_sketchybar="/run/current-system/sw/bin/sketchybar"

running_models=$(ps -x | grep -e 'uvx.*mlx_lm.server' | grep -v 'grep' | sed 's/.*--model \([^ ]*\).*--port \([^ ]*\).*$/\1:\2/' | sed 's,^mlx-community/,,')
if [ -z $running_models ]; then
    amount_of_models=0
else
    amount_of_models=$(echo $running_models | wc -l | sed 's/[ ]*\([^ ]*\).*/\1/')
fi

if [ $amount_of_models -eq 0 ]; then
    sketchybar --set "$NAME" icon.drawing=off label.drawing=off
else
    sketchybar --set "$NAME" \
                     icon.drawing=on icon="MLX" label.drawing=on label="$amount_of_models" \
                     click_script="$bin_path_sketchybar --set $NAME popup.drawing=toggle" \
                     popup.background.drawing=on \
                     popup.background.corner_radius=6 \
                     popup.align=right

    sketchybar --query $NAME | jq '.popup.items' | grep '"' | sed 's/[", ]//g' | xargs -I % sketchybar --remove popup.%

    for model in ${=running_models}; do
        sketchybar --add item $NAME.$model popup.$NAME --set $NAME.$model label="$(echo $model | cut -d: -f1)" icon="$(echo $model | cut -d: -f2)"
    done
fi
