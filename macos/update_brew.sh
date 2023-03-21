#!/bin/bash

root=$(pwd)
found=0

while [ $found -eq 0 ]; do
    if [[ $root = "/" ]]; then
        break
    fi

    echo "Searching for stow.sh in '$root'.."

    for file in $root/*; do
        f_name=$(basename "$file")

        if [ "$f_name" = "stow.sh" ]; then
            found=1
            break
        fi
    done

    if [ ! $found -eq 1 ]; then
        root=$(dirname $root)
    fi
done

if [ ! $found -eq 1 ]; then
    echo "Stow root not found"
    exit 1
else
    echo "Found stow root.."
fi

brew bundle dump && mv "$(pwd)/Brewfile" "$root/macos/brew/.Brewfile"
