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

# NOTE: Redirect init_home to the path of rice repo if this file is not at
# the root of rice
init_home=$(dirname $(realpath "$BASH_SOURCE"))

#rice_plugins=""

#rice_theme="my_bash"

. $init_home/ribash/ribash.sh
#-------------------------------------------------------------------------------
