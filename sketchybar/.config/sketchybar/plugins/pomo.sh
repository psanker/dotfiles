#!/usr/bin/env bash

source "$HOME/.config/sketchybar/colors.sh"

WORK_TIME=25
BREAK_TIME=5
 
handle_click() {
    status=$(pomo status)

    if [ -n "$status" ]; then
        cancel_pomo
    else
        start_pomo
    fi
}

start_pomo() {
    pomo start --duration $WORK_TIME

    view
}

cancel_pomo() {
    pomo cancel

    view
}

loop() {
    status=$(pomo status -f "%r")
    mode=$(pomo status -f "%d")

    if [ "$status" = "0:00" ]; then
        pomo clear
        pomo start break --duration $BREAK_TIME
    fi

    view
}

view() {
    status=$(pomo status)
    mode=""

    icon="􀐯"
    icon_highlight="$WHITE"
    icon_padding_right=10

    label_bg="off"
    label=""
    label_width="0"

    # View
    if [ -n "$status" ]; then
        mode=$(pomo status -f "%d")
        label="$(pomo status -f "%R")m"
        icon_padding_right=0
        label_width="dynamic"
        label_bg="on"

        if [ "$mode" = "break" ]; then
            icon="􁗁"
            icon_highlight="$GREEN"
        else
            icon="􀖇"
            icon_highlight="$RED"
        fi
    fi

    sketchybar --set "$NAME" icon="$icon" \
                             icon.highlight_color="$icon_highlight" \
                             icon.padding_right="$icon_padding_right" \
                             label="$label" \
                             label.width="$label_width" \
                             label.background.drawing="$label_bg" \
                             label.background.color="$BACKGROUND_1"
}

case "$SENDER" in
    "mouse.clicked") handle_click ;;
    "routine"|"forced") loop ;;
esac
