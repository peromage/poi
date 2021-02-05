#!/bin/sh
# Bash init template file.
# Modified by peromage on 2021/01/25

#region Initialization
#rice_features="test git"
#rice_theme="mybash"

# Load rice core init file. If this file has been moved to other places change
# this path accordingly. Otherwise it should stay untouched.
if [ -n "$BASH_VERSION" ]; then
    # Load rice
    . $(dirname $(realpath "$BASH_SOURCE"))/rice/rice.sh
    # Shortcu to this file
    init_file=$(realpath "$BASH_SOURCE")
else
    return
fi
#endregion
