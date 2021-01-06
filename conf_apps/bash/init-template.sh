#!/bin/sh
######################
## Author: peromage ##
## Date: 2020/02/17 ##
######################

# User configurations

# Theme in __rc__/themes directory. This value should be a string.
#RC_THEME="mybash"

# Modules in __rc__/modules directory. This value should be a list of comma
# separated array.
#RC_Modules="test"

# Override this variable if the shell cannot get the path of sourced file
#INIT_FILE=""

# Uncomment this variable to enable force reloading
#RC_INIT=""


#region Do Not Touch
# Check if in supported shell
# This RC_ROOT can be overridden if the shell doesn't support to get path of
# sourced file.
if [ -n "$INIT_FILE" ]; then
    INIT_FILE=$(realpath "$INIT_FILE")
elif [ -n "$BASH_VERSION" ]; then
    INIT_FILE=$(realpath "$BASH_SOURCE")
else
    return
fi
RC_ROOT="$(dirname "$INIT_FILE")/__rc__"

# Quick edit configuration file
RCInitFile() { 
    if [ -n $EDITOR ]; then
        eval "$EDITOR $INIT_FILE"
    else
        echo "No EDITOR found!"
    fi
}

# Load core file
eval ". $RC_ROOT/rc.sh"
#endregion
