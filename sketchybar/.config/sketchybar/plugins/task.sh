#!/usr/bin/env bash

TW_COUNT=$(task +TODAY count)
TW_ACTIVE=$(task "$(task +ACTIVE ids)" info | \
           grep Description | \
           head -n1 | \
           awk '{ for (i=2; i<=NF; i++) printf("%s%s", $i, (i<NF ? OFS : ORS))}')

TW_ACTIVE_SIZE=${#TW_ACTIVE}
TW_ACTIVE_MAX_LEN=35

if [ "$TW_ACTIVE_SIZE" -gt "$TW_ACTIVE_MAX_LEN" ]; then
    cut_size=$(( TW_ACTIVE_MAX_LEN - 3 ))
   TW_ACTIVE="$(echo "$TW_ACTIVE" | cut -c -"$cut_size")..."
fi

if [ "$TW_COUNT" -gt 0 ]; then
    label=""

    if [ "$TW_ACTIVE_SIZE" -gt 0 ]; then
        label="$TW_ACTIVE"
    fi

    sketchybar --set "$NAME" icon="􀷾 $TW_COUNT" \
                             label="$label" \
                             width=dynamic
else
    sketchybar --set "$NAME" icon="" label="" width=0
fi
