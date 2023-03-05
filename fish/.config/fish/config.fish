fish_add_path /usr/local/bin
fish_add_path /usr/local/go/bin
fish_add_path /usr/local/opt/llvm/bin
fish_add_path "$HOME/.spicetify"
fish_add_path "$HOME/.local/bin"
fish_add_path "$HOME/go/bin"
fish_add_path "$HOME/.cargo/bin"

set --export SHELL /usr/bin/fish
set --export VISUAL /usr/bin/nvim
set --export EDITOR "$VISUAL"
set --export PAGER less
set --export RSTUDIO_PANDOC /Applications/RStudio.app/Contents/MacOS/pandoc
set --export GPG_TTY (eval tty)
set --export LEDGER_FILE "$HOME/personal/pkm/finance/current.journal"
set --export BEMOJI_PICKER_CMD /usr/bin/rofi

set --export NNN_PLUG "p:preview-tui;f:fzopen;x:togglex"
set --export NNN_TRASH 1

set BLK "0B"
set CHR "0B"
set DIR "02" 
set EXE "09" 
set REG "07" 
set HARDLINK "06" 
set SYMLINK "05" 
set MISSING "04" 
set ORPHAN "04" 
set FIFO "03" 
set SOCK "03" 
set OTHER "0F"

set --export NNN_COLORS "6666"
set --export NNN_FCOLORS "$BLK$CHR$DIR$EXE$REG$HARDLINK$SYMLINK$MISSING$ORPHAN$FIFO$SOCK$OTHER"

if status is-interactive
    # Commands to run in interactive sessions can go here

    if test -x /usr/bin/jump
        jump shell fish | source
    end

    alias nv="nvim"
    alias gi="gitignore"
    alias pt="python3.10 -m poetry"
    alias bfg="java -jar $HOME/.local/bin/bfg.jar"
    alias sioyek="/Applications/sioyek.app/Contents/MacOS/sioyek"
    alias cat="bat"
    alias t="task"
    alias tw="taskwarrior-tui"
    alias hl="hledger"
    alias hlu="hledger-ui"
    alias hlw="hledger-web"

    alias gpl="git pull --rebase"
    alias gpu="git push"

    alias ls="exa --group-directories-first"
    alias la="exa -la --color=always --group-directories-first"
    alias ll="exa -l --color=always --group-directories-first"
    alias lt="exa -aT --color=always --group-directories-first"

    alias mvln="$HOME/.bin/mvln.sh"

    alias n="better_n -deaH"
    alias n3="better_n -deaH"
    alias nnn="better_n -deaH"

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
fish_add_path /home/pickle/.spicetify
