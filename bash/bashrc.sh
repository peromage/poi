#!/usr/bin/bash

# Author: Fang
# Date: 2020/02/17

# Don't add code before the initialization
#region Initialization DO NOT TOUCH
# Interactive mode initialization script
# Prevent from being loaded twice
if [ -z "$INIT_SH_LOADED" ]; then
    INIT_SH_LOADED=1
else
    return
fi
# If in non-interactive mode then exit
case "$-" in
    *i*) ;;
    *) return
esac

_scriptroot=$(dirname $(realpath $BASH_SOURCE))

function loadmodule {
    # $1: Folder where the module resides
    # $2: Module names. Separated by ','
    # Module name supports glob
    local modules=(${2//,/ })
    local found i m mp
    for i in ${modules[*]}; do
        mp="$1/$i.sh"
        for m in $mp; do
            if [ -e "$m" ]; then
                source "$m"
                found=1
            fi
        done
        if [ -z "$found" ]; then
            echo "Module not found $mp"
        fi
    done
}
#endregion

#region My code
loadmodule "$_scriptroot/modules" aliases
loadmodule "$_scriptroot/prompts" mybash
#endregion
