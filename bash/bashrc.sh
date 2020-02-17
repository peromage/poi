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
    modules=(${2//,/ })
    for i in ${modules[*]}; do
        temp="$1/$i.sh"
        if [ -f "$temp" ]; then
            . $temp
        else
            echo "Module not found: $temp"
        fi
    done
}
#endregion

#region My code
loadmodule "$_scriptroot/modules" "alias,test"
loadmodule "$_scriptroot/prompts" "mybash"
#endregion
