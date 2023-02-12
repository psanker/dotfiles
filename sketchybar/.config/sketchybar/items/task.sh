#!/usr/bin/env sh

sketchybar --add item task right \
           --set task icon=task \
                      icon.font="$FONT:Black:12.0" \
                      icon.highlight=true \
                      icon.highlight_color=$YELLOW \
                      icon.padding_left=10 \
                      icon.padding_right=10 \
                      label.padding_left=10 \
                      label.padding_right=15 \
                      label.align=right \
                      label.background.color=$BACKGROUND_2 \
                      label.background.height=26 \
                      label.background.corner_radius=9 \
                      label.width=0 \
                      background.color=$BACKGROUND_1 \
                      background.height=26 \
                      script="$PLUGIN_DIR/task.sh" \
                      updates=on \
                      update_freq=30

