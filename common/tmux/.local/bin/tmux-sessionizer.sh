#!/usr/bin/env bash

WORKTREE=0

if [ $# -eq 1 ]; then
  selected=$1
else
    cmd="find $HOME/workspace $HOME/personal $HOME/Documents"

    dirs_wt_roots=$(${cmd} -mindepth 2 -maxdepth 2 -type d | grep '**/.bare$')
    dirs_wt_roots=$(echo "$dirs_wt_roots" | sed 's:/.bare::g')
    dirs_wt=$(find $dirs_wt_roots -mindepth 1 -maxdepth 1 -type d -not -path '*/.*')
    arr_wt=($dirs_wt)
    
    dirs_nowt=$(${cmd} -mindepth 1 -maxdepth 1 -type d | grep '**')

    selected=$(printf "$dirs_wt\n$dirs_nowt" | fzf)

    for it in "${arr_wt[@]}"; do
        if [[ "$it" == "$selected" ]]; then
            WORKTREE=1
        fi
    done
fi

echo "$selected"

if [ -z $selected ]; then
  exit 0
fi

if [ $WORKTREE -eq 1 ]; then
    selected_name="$(basename $(dirname "$selected"))|$(basename "$selected")"
else
    selected_name=$(basename "$selected")
fi

selected_name=$(echo "$selected_name" | tr . _)
open_tmux=$(pgrep tmux)

if [ -z $TMUX ] && [ -z $open_tmux ]; then
  tmux new-session -s $selected_name -c $selected \; set default-shell /usr/bin/fish
fi

if ! tmux has-session -t=$selected_name 2> /dev/null; then
  tmux new-session -ds $selected_name -c $selected \; set default-shell /usr/bin/fish
fi

tmux switch-client -t $selected_name
