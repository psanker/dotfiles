#!/usr/bin/env bash

source "$HOME/.config/sketchybar/colors.sh"

TW_COUNT=$(task +TODAY or +OVERDUE or \(scheduled.before:tomorrow and due.after:today\) count)
TW_ACTIVE_ID=$(task +ACTIVE ids | cut -w -f1)

TW_ACTIVE=""
TW_ACTIVE_OVERDUE=""

if [ -n "$TW_ACTIVE_ID" ]; then
    TW_ACTIVE=$(task "$TW_ACTIVE_ID" info | \
                grep Description | \
                awk '{ for (i=2; i<=NF; i++) printf("%s%s", $i, (i<NF ? OFS : ORS))}')
    TW_ACTIVE_OVERDUE=$(task "$TW_ACTIVE_ID" info | \
                        grep "Virtual tags" | \
                        grep OVERDUE)
fi

TW_ACTIVE_SIZE=${#TW_ACTIVE}
TW_ACTIVE_MAX_LEN=35

if [ "$TW_ACTIVE_SIZE" -gt "$TW_ACTIVE_MAX_LEN" ]; then
    cut_size=$(( TW_ACTIVE_MAX_LEN - 3 ))
   TW_ACTIVE="$(echo "$TW_ACTIVE" | cut -c -"$cut_size")..."
fi


width="0"
bg="off"
icon=""
label=""
label_bg="off"
label_width="0"
label_bg_color="$BACKGROUND_2"

if [ "$TW_COUNT" -gt 0 ]; then
    bg="on"
    width="dynamic"
    icon="􀷾 $TW_COUNT" 

    if [ -n "$TW_ACTIVE" ]; then
        label_bg="on"
        label_width="dynamic"
        label="$TW_ACTIVE"

        if [ -n "$TW_ACTIVE_OVERDUE" ]; then
            label_bg_color="$RED"
        fi
    fi
fi

sketchybar --set "$NAME" icon="$icon" \
                         label="$label" \
                         label.width="$label_width" \
                         label.background.drawing="$label_bg" \
                         label.background.color="$label_bg_color" \
                         background.drawing="$bg" \
                         width="$width"
