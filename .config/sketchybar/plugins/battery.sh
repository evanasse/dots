#!/bin/zsh

chalet_dark_red=0xFFA74D39
chalet_light_brown=0xFFC69478

PERCENTAGE="$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)"
CHARGING="$(pmset -g batt | grep 'AC Power')"

if [ "$PERCENTAGE" = "" ]; then
    sketchybar --set "$NAME" icon.drawing=off label.drawing=off
    exit 0
fi

LABEL="$PERCENTAGE%"

case "${PERCENTAGE}" in
    10) BACKGROUND_COLOR=$chalet_dark_red
    ;;
    [1-9]) BACKGROUND_COLOR=$chalet_dark_red
    ;;
    *) BACKGROUND_COLOR=$chalet_light_brown
esac

if [[ "$CHARGING" != "" ]]; then
    LABEL=""
fi

# The item invoking this script (name $NAME) will get its icon and label
# updated with the current battery status
sketchybar --set "$NAME" icon="BAT" icon.background.color=$BACKGROUND_COLOR label="$LABEL"
