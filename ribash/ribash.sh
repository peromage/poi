#!/bin/sh
################################################################################
#
# Rice core config file for bash.
#
# Created by peromage 2021/02/24
# Last modified 2021/02/24
#
################################################################################

#-------------------------------------------------------------------------------
# Loading check
#-------------------------------------------------------------------------------
# If in non-interactive mode then exit
case "$-" in
    *i*) ;;
    *) return;;
esac

# Prevent being sourced twice
[ -n "$loaded_rice" ] && return
loaded_rice=1

# Is it bash?
# Compatibility check may be added here
if [ -n "$BASH_VERSION" ]; then
    ri_home=$(dirname $(realpath "$BASH_SOURCE"))
else
    return
fi

#-------------------------------------------------------------------------------
# Helper functions
#-------------------------------------------------------------------------------
ri_source_script() {
    . $ri_home/$1
}

ri_init_var() {
    local var=$1
    local value=$2
    if eval "[ -z \"\$$var\" ]"; then
        eval "$var=$value"
    fi
}

#-------------------------------------------------------------------------------
# Config variables
#-------------------------------------------------------------------------------
# Plugins to be loaded
ri_init_var rice_plugins ""
# Shell theme
ri_init_var rice_theme ""


#-------------------------------------------------------------------------------
# Initialization
#-------------------------------------------------------------------------------
# Load base scripts
ri_source_script base/10_common.sh

# Load theme
[ -n "$rice_theme" ] && ri_source_script themes/$rice_theme.sh

# Load plugins
for i in $rice_plugins; do
    ri_source_script plugins/$i.sh
done
unset i

# Add script fold to path
export PATH=$PATH:$ri_home/scripts
