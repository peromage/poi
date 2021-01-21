#!/bin/sh
# Bash init template file.
# Modified by peromage on 2021/01/20

#region Initialization
# Load rice core init file. If this file has been moved to other places change
# this path accordingly. Otherwise it should stay untouched.
if [ -n "$BASH_VERSION" ]; then
    . $(dirname $(realpath "$BASH_SOURCE"))/__rc__/rc.sh
    INIT_FILE=$(realpath "$BASH_SOURCE")
else
    return
fi
# Rice global configs
#RICE_THEME="mybash"
#RICE_MODULES="test aliases_git"
RiceConfigInit
#endregion
