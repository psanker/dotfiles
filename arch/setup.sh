#!/usr/bin/env bash

root=$(pwd)
found=0

while [ $found -eq 0 ]; do
    if [[ $root = "/" ]]; then
        break
    fi

    for file in $root/*; do
        if [[ "$file" = "stow.sh" ]]; then
            $found=1
            break
        fi
    done
done

if [ ! $found -eq 1 ]; then
    echo "Stow root not found"
    exit 1
fi

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
    "openbsd-netcat"
    "pipewire"
    "pipewire-audio"
    "pipewire-pulse"
    "protonmail-bridge-bin"
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

source "$root/stow.sh"
