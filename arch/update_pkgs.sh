#!/usr/bin/bash

if [ -x /usr/bin/yay ]; then
    echo "Please install yay"
    exit 1
fi

yay -Qeq >pkgs.txt
echo "Updated pkgs.txt"
