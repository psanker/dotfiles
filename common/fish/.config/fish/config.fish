fish_vi_key_bindings

set --export SHELL "$(which fish)"
set --export VISUAL "$(which nvim)"
set --export EDITOR "$VISUAL"
set --export GPG_TTY (eval tty)

if status is-interactive
    # Commands to run in interactive sessions can go here

    if test -x /usr/bin/jump || test -x /usr/local/bin/jump
        jump shell fish | source
    end

    if test -n "$(command -v direnv)"
        direnv hook fish | source
    end

    # Anti-footgun measures
    alias rm="rm -i"
    alias mv="mv -i"

    alias nv="nvim"
    alias gi="gitignore"
    alias pt="python3.10 -m poetry"
    alias bfg="java -jar $HOME/.local/bin/bfg.jar"
    alias cat="bat"
    alias hl="hledger"
    alias hlu="hledger-ui"
    alias hlw="hledger-web"
    alias nd="nix develop --command fish"

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

    alias mvln="$HOME/.bin/mvln.sh"

    alias n="$HOME/.local/bin/nnn.sh -deaHQ -Pp"
    alias nnn="$HOME/.local/bin/nnn.sh -deaHQ -Pp"

    alias r="R --no-save --no-restore"
    alias R="R --no-save --no-restore"

    alias t="task"
    alias tt="task +PENDING and \(+TODAY or +OVERDUE or \(scheduled.before:tomorrow and due.after:today\)\)"
    alias tdt="task completed end:today"
    alias ta="task add"
    alias tA="task $1 annotate"
    alias tm="task $1 modify"
    alias tW="task +WEEK or scheduled.before:saturday"
    alias tw="taskwarrior-tui"
    alias ts="task $1 start"
    alias tsy="task sync"
    alias tX="task $1 delete"
    
    alias z="sioyek"

    alias reload="source ~/.config/fish/config.fish"
end


if test -e "$HOME/.config/.env"
    source ~/.config/.env
end

# OCaml stuff
source $HOME/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true

# INIT STARSHIP
starship init fish | source

