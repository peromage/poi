<###############################################################################

.SYNOPSIS
This file should be sourced to initialize rice configs.

Created by peromage 2021/02/24
Last modified 2021/02/25

###############################################################################>

#===============================================================================
# Initialization
# NOTE: Replace $init_home to the path of rice repo if this file is not at
# the root of rice
$init_home = $PSScriptRoot
#-------------------------------------------------------------------------------
$init_file = $MyInvocation.MyCommand.Source
$ENV:PSModulePath += [IO.Path]::PathSeparator + $init_home
#-------------------------------------------------------------------------------
Import-Module ripwsh -ArgumentList @{

# Prompt theme
#-------------
#theme = "my_lite"

# A list of string for plugins under ripwsh/plugins
#--------------------------------------------------
#plugins = @()

}
#===============================================================================
