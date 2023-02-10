#!/usr/bin/env sh

TW_COUNT=$(task +TODAY count)

if [ $TW_COUNT -gt 0 ]; then
    sketchybar --set $NAME icon="􀷾" label="$TW_COUNT" width=dynamic
else
    sketchybar --set $NAME icon="" label="" width=0
fi

