#!/usr/bin/env bash

if [ ! -x /usr/bin/yay ]; then
    echo "Please install yay!"
    exit 1
fi

progs=(
    "exa"
    "nnn"
    "neovim"
    "starship"
    "eww-wayland-git"
    "rofi"
)

yay -S "${progs[@]}"
