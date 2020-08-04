#!/bin/sh
######################
## Author: peromage ##
## Date: 2020/02/17 ##
######################

# Loading guard
# Prevent from being loaded twice
[ -n "$RC_INIT" ] && return
# If in non-interactive mode then exit
case "$-" in
    *i*) ;;
    *) return;;
esac

# RC variables

# Check if in supported shell
# This RC_ROOT can be overridden if the shell doesn't support to get path of
# sourced file.
if [ -n "$RC_ROOT" ]; then
    RC_ROOT=$(realpath "$RC_ROOT")
elif [ -n "$BASH_VERSION" ]; then
    RC_ROOT=$(dirname $(realpath "$BASH_SOURCE"))
else
    return
fi
RC_CONFIG_ROOT=$(dirname $RC_ROOT)

# RC helper functions

# Module loader
# $1: Folder where the module resides
# $2: Module names. Separated by ','
# $3: The default module extension
# Note: Module name supports glob
function RCLoad {
    # Check if give module directory exists
    [ ! -d "$1" ] && return
    local previous_pwd=$(pwd)
    local current_pwd="$1"
    cd "$current_pwd"

    # Check if files exist in target directory and return a list of files
    local modules=(${2//,/ })

    # Check module extension
    local extension=".sh"
    [ -n "$3" ] && extension="$3"

    # Iterate through module list
    local i mod
    for i in ${modules[@]}; do
        # Strip suffix and append with expected module suffix
        mod="${i%.*}${extension}"
        # If module with suffix exists, source it.
        [ -f "$mod" ] && . "$mod"
    done
    cd "$previous_pwd"
}

# Local module loader
function RCLoadModule {
    [ -n "$1" ] && . "$RC_ROOT/modules/$1.sh"
}

# Start initialization

# Load all scripts in autoload
RCLoad "$RC_ROOT/autoload" "*"
# Load prompt style
[ -n "$RC_Prompt_Style" ] && RCLoad "$RC_ROOT/prompts" "$RC_Prompt_Style"
# Load extra modules
[ -n "$RC_Modules" ] && RCLoad "$RC_ROOT/modules" "$RC_Modules"
