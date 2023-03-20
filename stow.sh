#!/bin/bash

# Inspired by https://github.com/NeshHari/XMonad

POSITIONAL_ARGS=()

while [[ $# -gt 0 ]]; do
  case $1 in
    -v|--verbose)
      VERBOSE=1
      shift
      ;;
    -C|--common-only)
      COMMON_ONLY=1
      shift
      ;;
    -*|--*)
      echo "Unknown option $1"
      exit 1
      ;;
    *)
      POSITIONAL_ARGS+=("$1") # save positional arg
      shift # past argument
      ;;
  esac
done

set -- "${POSITIONAL_ARGS[@]}" # restore positional parameters

debug() {
    if [ $VERBOSE -eq 1 ]; then
        echo $1
    fi
}

stow_package() {
    package=$1

    stowignore="./$package/.stowignore"
    ignored_dirs=()
    stow_dirs=()

    if [ -f $stowignore ]; then
        while IFS= read -r line; do
            ignored_dirs+=($line)
        done < $stowignore
    fi

    for dir in $package/*; do
        if [ ! -d "$dir" ]; then
            continue
        fi

        if echo ${ignored_dirs[@]} | grep -q -w "$dir"; then
            debug "Skipping $dir.."
            continue
        fi

        if ! stow -d "$package" -t $HOME $(basename $dir); then
            stow_dirs+=($dir)
        fi
    done

    if [ ${#stow_dirs[@]} -gt 0 ]; then
        echo "The following $platform directories could not be stowed: ${stow_dirs[@]}"
        echo "Please manually copy the respective configs."
    fi

}

stow_package "common"

if [ -z $COMMON_ONLY ]; then
    if [ -z "$1" ]; then
        echo "Please provide a platform"
        exit 1
    fi

    stow_package "$1"
fi
