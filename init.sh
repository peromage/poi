#!/bin/sh
################################################################################
#
# Bash initialization template file
#
# Created by peromage 2021/02/24
# Last modified 2021/03/18
#
#
# This section should remain untouched
# Initialization
[ -z "$BASH_VERSION" ] && return
init_home=$(dirname $(realpath "$BASH_SOURCE"))
init_file=$(realpath "$BASH_SOURCE")
#
# Examples of configuration outside of ribash
#
# z.lua
#------
#eval "$(lua5.3 $init_home/bin/z.lua --init bash enhanced once)"
#
# Examples of configuration options of ribash
#
# Prompt theme
#-------------
#rice_theme="my-bash"
#
# Space separated string for mods under ribash/mods
#--------------------------------------------------------
#rice_mods="basic nav env"
#
################################################################################
### BEGIN: Rice config ###

### END: Rice config ###
. $init_home/ribash/ribash.sh
### Your config should start after this line ###
