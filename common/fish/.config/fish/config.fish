fish_vi_key_bindings

fish_add_path /usr/local/bin
fish_add_path /usr/local/go/bin
fish_add_path /opt/homebrew/bin
fish_add_path "$HOME/.local/bin"
fish_add_path "$HOME/go/bin"
fish_add_path "$HOME/.cargo/bin"
fish_add_path "$HOME/.cabal/bin"

if test (uname) = "Darwin"
    fish_add_path "$(brew --prefix)/opt/python3/libexec/bin"
end

set --export SHELL "$(which fish)"
set --export VISUAL "$(which nvim)"
set --export EDITOR "$VISUAL"
set --export PAGER less
set --export GPG_TTY (eval tty)
set --export LEDGER_FILE "$HOME/personal/pkm/finance/current.journal"

function fish_user_key_bindings
    # todoist
    bind -M insert \cti fzf_todoist_item
    bind -M insert \ctp fzf_todoist_project
    bind -M insert \ctl fzf_todoist_labels
    bind -M insert \ctc fzf_todoist_close
    bind -M insert \ctd fzf_todoist_delete
    bind -M insert \cto fzf_todoist_open
    bind -M insert \ctt fzf_todoist_date
    bind -M insert \ctq fzf_todoist_quick_add
end

if status is-interactive
    # Commands to run in interactive sessions can go here

    if test -x /usr/bin/jump || test -x /usr/local/bin/jump
        jump shell fish | source
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

    alias r="r --no-save --no-restore"
    alias R="R --no-save --no-restore"

    alias t="task"
    alias tt="task +PENDING and \(+TODAY or +OVERDUE or \(scheduled.before:tomorrow and due.after:today\)\)"
    alias tdt="task completed end:today"
    alias ta="task add"
    alias tm="task $1 modify"
    alias tW="task +WEEK or scheduled.before:saturday"
    alias tw="taskwarrior-tui"
    alias ts="task $1 start"
    alias tsy="task sync"
    alias tX="task $1 delete"
    
    alias z="sioyek"

    alias reload="source ~/.config/fish/config.fish"

    fish_user_key_bindings
end


if test -e "$HOME/.config/.env"
    source ~/.config/.env
end

set -gx VOLTA_HOME "$HOME/.volta"
set -gx PATH "$VOLTA_HOME/bin" $PATH

# OCaml stuff
source $HOME/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true

# INIT STARSHIP
starship init fish | source

