set -o vi

export VISUAL="$(command -v nvim)"
export EDITOR="$VISUAL"
export GPG_TTY="$(tty)"

alias rm="rm -i"
alias mv="mv -i"

alias nv="nvim"
alias cat="bat"
alias nd="nix develop"

alias gs="git status"
alias ga="git add"
alias gc="git commit"
alias gpl="git pull --rebase"
alias gplS="git pull --rebase origin main && git submodule foreach --recursive git pull --rebase origin main"
alias gpu="git push"
alias gco="git checkout"
alias gf="git fetch"
alias gr="git rebase"
alias gS="git submodule foreach --recursive"

alias ls="eza --group-directories-first"
alias la="eza -la --color=always --group-directories-first"
alias ll="eza -l --color=always --group-directories-first"
alias lt="eza -aT --color=always --group-directories-first --level=3"

alias r="R --no-save --no-restore"
alias R="R --no-save --no-restore"

if test -e "$HOME/.cargo/env"; then
    source "$HOME/.cargo/env"
fi

if test -e "$HOME/.config/.env"; then
    source "$HOME/.config/.env"
fi
