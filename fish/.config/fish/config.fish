fish_add_path /usr/local/bin
fish_add_path "/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
fish_add_path /Users/patrickanker/.local/bin
fish_add_path /Library/Frameworks/Python.framework/Versions/3.10/bin
fish_add_path /Applications/RStudio.app/Contents/MacOS
fish_add_path "$HOME/go"
fish_add_path "$HOME/.cargo/bin"
fish_add_path /usr/local/opt/llvm/bin

set --export SHELL /usr/local/bin/fish
set --export VISUAL nvim
set --export EDITOR "$VISUAL"
set --export RSTUDIO_PANDOC /Applications/RStudio.app/Contents/MacOS/pandoc
set --export GPG_TTY (eval tty)

if status is-interactive
    # Commands to run in interactive sessions can go here

    alias nv="nvim"
    alias gi="gitignore"
    alias pt="python3.10 -m poetry"
    alias bfg="java -jar $HOME/.local/bin/bfg.jar"
    alias sioyek="/Applications/sioyek.app/Contents/MacOS/sioyek"
end

source ~/.config/.env
set -gx VOLTA_HOME "$HOME/.volta"
set -gx PATH "$VOLTA_HOME/bin" $PATH

set -gx CC "/usr/local/opt/llvm/bin/clang"
set -gx LDFLAGS "-L/usr/loca/opt/llvm/lib"
set -gx CPPFLAGS "-I/usr/local/opt/llvm/include"

# INIT STARSHIP
starship init fish | source
