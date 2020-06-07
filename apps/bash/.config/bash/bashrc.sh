#!/usr/bin/bash

# Author: Fang
# Date: 2020/02/17

# Don't add code before the initialization
# Interactive mode initialization script
# Prevent from being loaded twice
if [ -z "$RCINIT" ]; then
    RCINIT=1
else
    return
fi
# If in non-interactive mode then exit
case "$-" in
    *i*) ;;
    *) return ;;
esac

RCROOT=$(dirname $(realpath $BASH_SOURCE))

# Module loader
function RCLoadModules {
    # $1: Folder where the module resides
    # $2: Module names. Separated by ','
    # $3: The default module extension
    # Note: Module name supports glob

    # Check if give module directory exists
    [ ! -d "$1" ] && return
    # Change current working directory
    local modules i md ext savedcwd
    savedcwd=$(pwd)
    cd $1
    # Expand glob in current module directory
    modules=(${2//,/ })
    # Module extension
    if [ -z "$3" ]; then
        ext=".sh"
    else
        ext=$3
    fi
    # Iterate through module list
    for i in ${modules[@]}; do
        # Strip suffix and append with expected module suffix
        md="${i%.*}$ext"
        # If module with suffix exists, source it.
        [ -f "$md" ] && . "$md"
    done
    # Restore working directory
    cd "$savedcwd"
}

# Local module loader
function RCModule {
    [ -z "$1" ] && return
    . "$RCROOT/__rcmodules__/$1.sh"
}
# End prerequisites

function RCInit {
    # This function's parameters correspond to the rc's parameters
    # This rc script
    RCLoadModules "$RCROOT/__rc__" "*"
    # Load prompt style
    if [ -z "$1" ]; then
        RCLoadModules "$RCROOT/__rcstyles__" mybash
    else
        RCLoadModules "$RCROOT/__rcstyles__" "$1"
    fi
}

RCInit "$@"
