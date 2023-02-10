#!/usr/bin/env sh

sketchybar --add item task right \
           --set task icon=task \
                      icon.font="$FONT:Black:12.0" \
                      icon.highlight=true \
                      icon.highlight_color=$YELLOW \
                      icon.padding_left=15 \
                      icon.padding_right=5 \
                      label.padding_right=15 \
                      label.align=right \
                      background.color=$BACKGROUND_1 \
                      background.height=26 \
                      script="$PLUGIN_DIR/task.sh" \
                      update_freq=30

