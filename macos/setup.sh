#!/bin/bash

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

# Stow dotfiles
exec "$root/stow.sh macos"

# Install software
brew bundle install --file=~/.Brewfile

