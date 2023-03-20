#!/bin/bash

BLK="0B"
CHR="0B"
DIR="02" 
EXE="09" 
REG="07" 
HARDLINK="06" 
SYMLINK="05" 
MISSING="04" 
ORPHAN="04" 
FIFO="03" 
SOCK="03" 
OTHER="0F"

export NNN_COLORS="6666"
export NNN_FCOLORS="$BLK$CHR$DIR$EXE$REG$HARDLINK$SYMLINK$MISSING$ORPHAN$FIFO$SOCK$OTHER"

export NNN_PLUG="p:preview-tui;f:fzopen;x:togglex"
export NNN_TRASH=1

if [ -n "$NNNLVL" ] && [ $NNNLVL -ge 1 ]; then
    echo "nnn is already running"
    exit 1
fi

if [ -n "$XDG_CONFILE_HOME" ]; then
    export NNN_TMPFILE="$XDG_CONFILE_HOME/nnn/.lastd"
else
    export NNN_TMPFILE="$HOME/.config/nnn/.lastd"
fi

exec $(which nnn) $@

if [ -e "$NNN_TMPFILE" ]; then
    source "$NNN_TMPFILE"
    rm -f "$NNN_TMPFILE"
fi
