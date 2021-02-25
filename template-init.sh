#!/bin/sh
################################################################################
#
# Bash initialization template file
#
# Created by peromage 2021/02/24
# Last modified 2021/02/24
#
################################################################################

#-------------------------------------------------------------------------------
# Initialization
#-------------------------------------------------------------------------------
[ -z "$BASH_VERSION" ] && return

# Shortcu to this file
init_file=$(realpath "$BASH_SOURCE")

# Load rice core init file. If this file has been moved to other places change
# this path accordingly. Otherwise it should stay untouched.
ribash_file=$(dirname $(realpath "$BASH_SOURCE"))/ribash/ribash.sh

#rice_plugins=""

#rice_theme="my_bash"

. $ribash_file
#-------------------------------------------------------------------------------
