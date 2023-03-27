#!/bin/bash

# Inspired by https://github.com/NeshHari/XMonad

show_help() {
    echo "Usage: $(basename $0) [-v] [-C] [-h]"
    echo "  -C: Stow the common configuration files only"
    echo "  -v: Show verbose messages"
    echo "  -h: Show this help message"
}

while getopts ':vC' OPTION; do
  case "$OPTION" in
    v)
      VERBOSE=1
      ;;
    C)
      COMMON_ONLY=1
      ;;
    h)
        show_help
        exit 0
        ;;
    ?)
      show_help
      exit 1
      ;;
  esac
done

shift "$(( $OPTIND - 1 ))"

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

    verbose_stow=""

    if [ $VERBOSE -eq 1 ]; then
        verbose_stow="-v"
    fi

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

        if ! stow -d "$package" -t $HOME "$verbose_stow" $(basename $dir); then
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
    PLATFORM="$1"

    if [ -z "$PLATFORM" ]; then
        agent=$(uname)

        case $agent in
            Linux) 
                PLATFORM="arch" 
                debug "Using 'arch' as a default.."
                ;;
            Darwin)
                PLATFORM="macos"
                debug "Using 'macos' as a default.."
                ;;
            *)
                echo "Please provide a platform"
                exit 1
                ;;
        esac
    fi

    stow_package "$PLATFORM"
fi
