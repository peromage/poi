<#
.SYNOPSIS
This file should be sourced to initialize rice configs.
Modified by peromage on 2021/01/24
#>

#region Initialization
# Shortcut to edit the init file
$init_file = $MyInvocation.MyCommand.Source
# Add rice module path
# For Linux/Mac change ";" to ":"
$ENV:PSModulePath += ";" + $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath("$PSScriptRoot/modules")
Import-Module rice -ArgumentList @{

#Theme = "my_lite"
#Features = @("shim")

}
#endregion
