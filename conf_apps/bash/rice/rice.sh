#!/bin/sh
# Rice core config file for bash.
# Modified by peromage on 2021/01/25

#region Source guard

# If in non-interactive mode then exit
case "$-" in
    *i*) ;;
    *) return;;
esac

# Prevent being sourced twice
[ -n "$loaded_rice" ] && return
loaded_rice=1

#endregion

#region Global config variables

# Initiaize rice config for bash
if [ -n "$BASH_VERSION" ]; then
    rice_root=$(dirname $(realpath "$BASH_SOURCE"))
else
    return
fi

# Environment variables
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
export EDITOR=nvim

# Default configurations
# Additional features. Space separated string list.
[ -z "$rice_features" ] && rice_features=""
# Shell theme
[ -z "$rice_theme" ] && rice_theme=""

#endregion

#region Helper functions

function _riceSourceFiles {
    # Source the given paths. Wildcard can be used to match the file names when
    # calling this function.
    # $@: Module paths.
    local i
    for i in $@; do
        [ -f "$i" ] && . "$i"
    done
}

#endregion

#region Initialization

# Load base scripts
_riceSourceFiles $rice_root/base/*.sh
# Load additonal features
if [ -n "$rice_features" ]; then
    for i in $rice_features; do
        _riceSourceFiles $rice_root/features/$i.sh
    done
    unset i
fi
# Load theme
if [ -n "$rice_theme" ]; then
    _riceSourceFiles $rice_root/themes/$rice_theme.sh
fi
# Add script fold to path
export PATH=$PATH:$rice_root/scripts

#endregion
