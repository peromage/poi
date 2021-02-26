<###############################################################################

.SYNOPSIS
This file should be sourced to initialize rice configs.

Created by peromage 2021/02/24
Last modified 2021/02/24

###############################################################################>

<#------------------------------------------------------------------------------
Initialization
------------------------------------------------------------------------------#>
# Shortcut to edit the init file
$init_file = $MyInvocation.MyCommand.Source

# NOTE: Replace $PSScriptRoot to the path of rice repo if this file is not at
# the root of rice
# For Linux/Mac change ";" to ":"
$ENV:PSModulePath += ";" + $PSScriptRoot

Import-Module ripwsh -ArgumentList @{

#theme = "my_lite"

#plugins = @()

}
#-------------------------------------------------------------------------------
