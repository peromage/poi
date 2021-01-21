#!/bin/sh
# Rice core config file for bash.
# Modified by peromage on 2021/01/20

# If in non-interactive mode then exit
case "$-" in
    *i*) ;;
    *) return;;
esac

function RiceConfigInit {
# Initiaize rice config for bash
if [ -n "$BASH_VERSION" ]; then
    RICE_ROOT=$(dirname $(realpath "$BASH_SOURCE"))
else
    return
fi

# Rice functions
function RiceModuleImport {
    # Import the given module path. Wildcard is supported.
    # $1: Module path.
    local i
    for i in "$@"; do
        [ -f "$i" ] && . "$i"
    done
}
function RiceLoadModule {
    RiceModuleImport $RICE_ROOT/modules/$1.sh
}
function RiceLoadTheme {
    RiceModuleImport $RICE_ROOT/themes/$1.sh
}

# Load modules in autoload.d directory
RiceModuleImport $RICE_ROOT/autoload.d/*.sh
# Load prompt style
if [ -n "$RICE_THEME" ]; then
    RiceLoadTheme "$RICE_THEME"
fi
# Load extra modules
if [ -n "$RICE_MODULES" ]; then
    for i in $RICE_MODULES; do
        RiceLoadModule "$i"
    done
    unset i
fi

} #RiceConfigInit
