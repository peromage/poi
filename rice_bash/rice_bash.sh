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

# Default configurations
# Additional plugins. Space separated string list.
[ -z "$rice_plugins" ] && rice_plugins=""
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
# Load additonal plugins
if [ -n "$rice_plugins" ]; then
    for i in $rice_plugins; do
        _riceSourceFiles $rice_root/plugins/$i.sh
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
