# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc

if [[ $- == *i* ]]; then
    if command -v starship >/dev/null 2>&1; then eval "$(starship init bash)"; fi
    if command -v direnv >/dev/null 2>&1; then eval "$(direnv hook bash)"; fi
    if command -v wt >/dev/null 2>&1; then eval "$(command wt config shell init bash)"; fi

    . ~/.local/bin/interactive-sh.sh
fi

