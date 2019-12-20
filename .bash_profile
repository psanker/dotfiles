export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
alias ls='ls -gH'

export PS1="\[\033[38;5;25m\]\u\[$(tput bold)\]\[$(tput sgr0)\]\[\033[38;5;238m\]@\[$(tput sgr0)\]\[$(tput sgr0)\]\[\033[38;5;240m\]\h\[$(tput sgr0)\]\[\033[38;5;238m\]:\[$(tput sgr0)\]\[\033[38;5;2m\]\W\[$(tput sgr0)\]\[\033[38;5;7m\]\\$\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]"

##
# Your previous /Users/patrick/.bash_profile file was backed up as /Users/patrick/.bash_profile.macports-saved_2015-12-25_at_13:19:26
##

alias tmux="tmux -2"

# RESET PATH
export PATH="/usr/bin:/usr/sbin:/bin:/sbin"
export PATH="/usr/local/bin:$PATH"

# MacPorts Installer addition on 2015-12-25_at_13:19:26: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
# Finished adapting your PATH environment variable for use with MacPorts.

alias rmdsstore="find . -name '*.DS_Store' -type f -delete"

# Neovim
alias nv="nvim"

# Setting PATH for Python 3.5
# The orginal version is saved in .bash_profile.pysave
export PATH="/Library/Frameworks/Python.framework/Versions/3.5/bin:${PATH}"

# GDAL
export PATH="/Library/Frameworks/GDAL.framework/Programs:$PATH"

# CMake
export PATH="/Applications/CMake.app/Contents/bin:$PATH"

# Julia
export PATH="/Applications/Julia-1.1.app/Contents/Resources/julia/bin:$PATH"

# Julia 0.7
alias julia7="/Applications/Julia-0.7.app/Contents/Resources/julia/bin/julia"

# Julia 1.0
alias julia6="/Applications/Julia-0.6.app/Contents/Resources/julia/bin/julia"

# Force Julia to use Py3
export CONDA_JL_VERSION="3"

# idk somehow fixes syntastic
export LC_CTYPE=en_US.UTF-8

export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# LaTeX
export PATH="/Library/TeX/texbin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# ROOT
alias thisroot=". ~/dev/root/bin/thisroot.sh"

# added by Anaconda3 5.3.0 installer
# >>> conda init >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$(CONDA_REPORT_ERRORS=false '/anaconda3/bin/conda' shell.bash hook 2> /dev/null)"
if [ $? -eq 0 ]; then
    \eval "$__conda_setup"
else
    if [ -f "/anaconda3/etc/profile.d/conda.sh" ]; then
# . "/anaconda3/etc/profile.d/conda.sh"  # commented out by conda initialize
        CONDA_CHANGEPS1=false conda activate base
    else
        \export PATH="/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda init <<<

# conda envs
alias py36="conda activate py36"
alias py37="conda activate py37"
# added by Anaconda3 2018.12 installer
# >>> conda init >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$(CONDA_REPORT_ERRORS=false '/anaconda3/bin/conda' shell.bash hook 2> /dev/null)"
if [ $? -eq 0 ]; then
    \eval "$__conda_setup"
else
    if [ -f "/anaconda3/etc/profile.d/conda.sh" ]; then
# . "/anaconda3/etc/profile.d/conda.sh"  # commented out by conda initialize
        CONDA_CHANGEPS1=false conda activate base
    else
        \export PATH="/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda init <<<

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/patrickanker/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/patrickanker/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/patrickanker/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/patrickanker/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

