#!/usr/bin/env bash

if [ ! -x /usr/bin/yay ]; then
    echo "Please install yay!"
    exit 1
fi

progs=(
    "apple_cursor"
    "eww-wayland-git"
    "exa"
    "gammastep"
    "hyprpaper"
    "neovim"
    "nnn"
    "rclone"
    "rofi-lbonn-wayland-git"
    "rofimoji"
    "sddm-theme-corners-git"
    "socat"
    "starship"
    "task"
    "taskwarrior-tui"
    "ttf-apple-emoji"
    "ttf-mac-fonts"
    "wtype"
)

yay -Sy "${progs[@]}"

source ./stow.sh
