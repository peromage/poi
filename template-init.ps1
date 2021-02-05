<#
.SYNOPSIS
This file should be sourced to initialize rice configs.
Modified by peromage on 2021/02/05
#>

# Initialization
#-------------------------------------------------------------------------------
# Shortcut to edit the init file
$init_file = $MyInvocation.MyCommand.Source
# Add rice module path
# For Linux/Mac change ";" to ":"
$ENV:PSModulePath += ";" + $PSScriptRoot
Import-Module rice_pwsh -ArgumentList @{

#theme = "my_lite"
#plugins = @("lf", "shim")

}
#-------------------------------------------------------------------------------
