fish_add_path /usr/local/bin
fish_add_path "/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
fish_add_path /Users/patrickanker/.local/bin
fish_add_path /Library/Frameworks/Python.framework/Versions/3.10/bin
fish_add_path /Applications/RStudio.app/Contents/MacOS
fish_add_path /usr/local/go/bin
fish_add_path "$HOME/go"
fish_add_path "$HOME/.cargo/bin"
fish_add_path /usr/local/opt/llvm/bin

set --export SHELL /usr/local/bin/fish
set --export VISUAL nvim
set --export EDITOR "$VISUAL"
set --export RSTUDIO_PANDOC /Applications/RStudio.app/Contents/MacOS/pandoc
set --export GPG_TTY (eval tty)
set --export LEDGER_FILE "$HOME/personal/pkm/finance/current.journal"

set --export NNN_PLUG "p:preview-tui;f:fzopen"
set --export NNN_FIFO "/tmp/nnn.fifo"
set --export SPLIT "v"

if status is-interactive
    # Commands to run in interactive sessions can go here

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

    alias nnn="nnn -dea"
    alias ls="nnn -dea"
    alias ll="nnn -dea"
    alias la="nnn -deHa"
end

source ~/.config/.env
set -gx VOLTA_HOME "$HOME/.volta"
set -gx PATH "$VOLTA_HOME/bin" $PATH

set -gx CC "/usr/local/opt/llvm/bin/clang"
set -gx LDFLAGS "-L/usr/loca/opt/llvm/lib"
set -gx CPPFLAGS "-I/usr/local/opt/llvm/include"

# INIT STARSHIP
starship init fish | source
