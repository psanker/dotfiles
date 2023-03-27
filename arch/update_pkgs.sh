#!/usr/bin/bash
root=$(pwd)
found=0

while [ $found -eq 0 ]; do
    if [[ $root = "/" ]]; then
        break
    fi

    for file in $root/*; do
        if [[ "$(basename $file)" = "stow.sh" ]]; then
            found=1
            break
        fi
    done

    if [ $found -eq 0 ]; then
        root=$(dirname $root)
    fi
done

if [ ! $found -eq 1 ]; then
    echo "Stow root not found"
    exit 1
fi

if [ ! -x /usr/bin/yay ]; then
    echo "Please install yay"
    exit 1
fi

yay -Qeq >"$root/arch/pkgs.txt"
echo "Updated arch/pkgs.txt"
