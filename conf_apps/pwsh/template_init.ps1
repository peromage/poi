<#
.SYNOPSIS
This file should be sourced to initialize rice configs.
Modified by peromage on 2021/01/24
#>

#region Initialization
# Shortcut to edit the init file
$init_file = $MyInvocation.MyCommand.Source
# Add rice module path
# For Linux/Mac this value should be like ":$PSScriptRoot/modules"
$ENV:PSModulePath += ";$PSScriptRoot\modules"
Import-Module rice

# Rice global configs
#$global:rice_configs = @{
#Theme = "my_lite"
#Features = @("shim")
#}

Initialize-Rice
#endregion
