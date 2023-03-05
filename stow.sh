#!/bin/bash

# Inspired by https://github.com/NeshHari/XMonad

stow_dirs=()
for dir in *; do
	if ! stow $dir; then
		stow_dirs+=($dir)
	fi
done

# Check if there are any failed directories
if [ ${#stow_dirs[@]} -gt 0 ]; then
	echo "The following directories could not be stowed: ${stow_dirs[@]}"
	echo "Please manually copy the respective configs."
fi
