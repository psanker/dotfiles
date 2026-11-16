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

    selected=$(printf "$dirs_wt\n$dirs_nowt" | fzf --style full --preview 'fzf-preview.sh {}')

    for it in "${arr_wt[@]}"; do
        if [[ "$it" == "$selected" ]]; then
            WORKTREE=1
        fi
    done
fi

echo "$selected"

if [ -z "$selected" ]; then
  exit 0
fi

if [ $WORKTREE -eq 1 ]; then
  ws_name="$(basename "$(dirname "$selected")")|$(basename "$selected")"
else
  ws_name=$(basename "$selected")
fi

ws_name=$(echo "$ws_name" | tr . _)

herdr status 2>&1 | grep -q 'not running' && herdr &

ws_id=$(herdr workspace list | jq -r ".result | .workspaces[] | select(contains({label: \"$ws_name\"})) | .workspace_id")

if [ -z "$ws_id" ]; then
    herdr workspace create --label "$ws_name" --cwd "$selected" --focus
else
    herdr workspace focus "$ws_id"
fi
