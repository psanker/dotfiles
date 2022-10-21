#!/usr/bin/env bash

if [ $# -eq 1 ]; then
  selected=$1
else
  selected=$(find $HOME/dev $HOME/workspace $HOME/personal -type d -mindepth 1 -maxdepth 1 | fzf)
fi

echo "$selected"

if [ -z $selected ]; then
  exit 0
fi

selected_name=$(basename "$selected" | tr . _)
open_tmux=$(pgrep tmux)

if [ -z $TMUX ] && [ -z $open_tmux ]; then
  tmux new-session -s $selected_name -c $selected
fi

if ! tmux has-session -t=$selected_name 2> /dev/null; then
  tmux new-session -ds $selected_name -c $selected
fi

tmux switch-client -t $selected_name
