#!/usr/bin/env bash

if [ ! -x /usr/bin/yay ]; then
    echo "Please install yay!"
    exit 1
fi

progs=(
    "socat"
    "exa"
    "nnn"
    "neovim"
    "starship"
    "eww-wayland-git"
    "rofi"
    "sddm-theme-corners-git"
    "task"
    "taskwarrior-tui"
    "rclone"
    "wtype"
    "bemoji-git"
)

yay -S "${progs[@]}"
