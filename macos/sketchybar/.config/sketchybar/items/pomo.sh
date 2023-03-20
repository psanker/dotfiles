#!/usr/bin/env sh

sketchybar --add item pomo right \
           --subscribe pomo mouse.clicked \
           --set pomo icon=pomo \
                      background.padding_right=-5 \
                      width="dynamic" \
                      icon.font="$FONT:Black:12.0" \
                      icon.highlight=true \
                      icon.highlight_color=$WHITE \
                      icon.padding_left=10 \
                      icon.padding_right=10 \
                      label.padding_left=10 \
                      label.padding_right=10 \
                      label.align=right \
                      label.background.color=$BACKGROUND_1 \
                      label.background.height=26 \
                      label.background.corner_radius=9 \
                      label.width=0 \
                      background.color=$BACKGROUND_1 \
                      background.height=26 \
                      script="$PLUGIN_DIR/pomo.sh" \
                      updates=on \
                      update_freq=5

