fish_vi_key_bindings

fish_add_path /usr/local/bin
fish_add_path /usr/local/go/bin
fish_add_path /usr/local/opt/llvm/bin
fish_add_path "$HOME/.local/bin"
fish_add_path "$HOME/go/bin"
fish_add_path "$HOME/.cargo/bin"

set --export SHELL "$(which fish)"
set --export VISUAL "$(which nvim)"
set --export EDITOR "$VISUAL"
set --export PAGER less
set --export GPG_TTY (eval tty)
set --export LEDGER_FILE "$HOME/personal/pkm/finance/current.journal"

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

    alias gs="git status"
    alias ga="git add"
    alias gc="git commit"
    alias gpl="git pull --rebase"
    alias gplS="git pull --rebase origin main && git submodule foreach --recursive git pull --rebase origin main"
    alias gpu="git push"

    alias ls="exa --group-directories-first"
    alias la="exa -la --color=always --group-directories-first"
    alias ll="exa -l --color=always --group-directories-first"
    alias lt="exa -aT --color=always --group-directories-first"

    alias mvln="$HOME/.bin/mvln.sh"

    alias n="$HOME/.local/bin/nnn.sh -deaHQ -Pp"
    alias nnn="$HOME/.local/bin/nnn.sh -deaHQ -Pp"

    alias t="task"
    alias tt="task +TODAY"
    alias ta="task add"
    alias td="task $1 done"
    alias tm="task $1 modify"
    alias tW="task +WEEK"
    alias tw="taskwarrior-tui"

    alias z="zathura"
    alias zf="z (fzf)"

    alias reload="source ~/.config/fish/config.fish"
end

if test -e "$HOME/.config/.env"
    source ~/.config/.env
end

set -gx VOLTA_HOME "$HOME/.volta"
set -gx PATH "$VOLTA_HOME/bin" $PATH

# INIT STARSHIP
starship init fish | source
