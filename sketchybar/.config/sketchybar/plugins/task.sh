#!/usr/bin/env bash

source "$HOME/.config/sketchybar/colors.sh"

TW_COUNT=$(task +TODAY count)
TW_ACTIVE_ID=$(task +ACTIVE ids | cut -w -f1)
TW_ACTIVE=$(task "$TW_ACTIVE_ID" info | \
            grep Description | \
            awk '{ for (i=2; i<=NF; i++) printf("%s%s", $i, (i<NF ? OFS : ORS))}')
TW_ACTIVE_OVERDUE=$(task "$TW_ACTIVE_ID" info | \
                    grep "Virtual tags" | \
                    grep OVERDUE)

TW_ACTIVE_SIZE=${#TW_ACTIVE}
TW_ACTIVE_MAX_LEN=35

if [ "$TW_ACTIVE_SIZE" -gt "$TW_ACTIVE_MAX_LEN" ]; then
    cut_size=$(( TW_ACTIVE_MAX_LEN - 3 ))
   TW_ACTIVE="$(echo "$TW_ACTIVE" | cut -c -"$cut_size")..."
fi

if [ "$TW_COUNT" -gt 0 ]; then
    active_bg="$BACKGROUND_2"

    if [ -n "$TW_ACTIVE_OVERDUE" ]; then
        active_bg="$RED"
    fi

    if [ "$TW_ACTIVE_SIZE" -gt 0 ]; then
        sketchybar --set "$NAME" icon="􀷾 $TW_COUNT" \
                                 label="$TW_ACTIVE" \
                                 label.width=dynamic \
                                 label.background.color="$active_bg" \
                                 width=dynamic
    else
        sketchybar --set "$NAME" icon="􀷾 $TW_COUNT" \
                                 label="" \
                                 label.width=0 \
                                 label.background.color="$active_bg" \
                                 width=dynamic
    fi
else
    sketchybar --set "$NAME" icon="" label="" width=0
fi
