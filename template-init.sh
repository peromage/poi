#!/bin/sh
# Bash init template file.
# Modified by peromage on 2021/02/05

#Initialization
#-------------------------------------------------------------------------------
#rice_plugins="lf test"
#rice_theme="mybash"

# Load rice core init file. If this file has been moved to other places change
# this path accordingly. Otherwise it should stay untouched.
if [ -n "$BASH_VERSION" ]; then
    # Load rice
    . $(dirname $(realpath "$BASH_SOURCE"))/rice_bash/rice_bash.sh
    # Shortcu to this file
    init_file=$(realpath "$BASH_SOURCE")
else
    return
fi
#-------------------------------------------------------------------------------
