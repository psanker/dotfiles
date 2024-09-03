#!/usr/bin/env bash

source "$HOME/.config/sketchybar/colors.sh"

WORK_TIME=50
BREAK_TIME=10

POMO=~/go/bin/pomo
 
handle_click() {
    status=$(${POMO} status)

    if [ -n "$status" ]; then
        cancel_pomo
    else
        start_pomo
    fi
}

start_pomo() {
    ${POMO} start --duration $WORK_TIME

    view
}

cancel_pomo() {
    ${POMO} cancel

    view
}

loop() {
    status=$(${POMO} status -f "%r")
    mode=$(${POMO} status -f "%d")

    if [ "$status" = "0:00" ]; then
        ${POMO} clear
        
        if [ "$mode" != "break" ]; then
            ${POMO} start break --duration $BREAK_TIME
        fi
    fi

    view
}

view() {
    status=$(${POMO} status)
    mode=""

    icon="􀐯"
    icon_highlight="$WHITE"
    icon_padding_right=10

    label_bg="off"
    label=""
    label_width="0"

    # View
    if [ -n "$status" ]; then
        mode=$(${POMO} status -f "%d")
        label="$(${POMO} status -f "%R")m"
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
