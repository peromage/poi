#!/bin/sh
################################################################################
#
# Bash initialization template file
#
# Created by peromage 2021/02/24
# Last modified 2021/02/25
#
################################################################################

#===============================================================================
[ -z "$BASH_VERSION" ] && return
#-------------------------------------------------------------------------------
# Initialization
# NOTE: Redirect init_home to the path of rice repo if this file is not at
# the root of rice
init_home=$(dirname $(realpath "$BASH_SOURCE"))
#-------------------------------------------------------------------------------
init_file=$(realpath "$BASH_SOURCE")
#-------------------------------------------------------------------------------

# Prompt theme
#-------------
#rice_theme="my_bash"

# Space separated string for mods under ribash/mods
#--------------------------------------------------------
#rice_mods="basic nav env"

#-------------------------------------------------------------------------------
. $init_home/ribash/ribash.sh
#===============================================================================

# z.lua
#eval "$(lua54 $init_home/bin/z.lua --init bash enhanced once)"
