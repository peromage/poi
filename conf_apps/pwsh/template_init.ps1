<#
.SYNOPSIS
This file should be sourced to initialize rice configs.
Modified by peromage on 2021/01/20
#>

#region Initialization
# Load rice core init file. If this file has been moved to other places change
# this path accordingly. Otherwise it should stay untouched.
. "${PSScriptRoot}/__rc__/rc.ps1"
# Shortcut to edit the init file
$INIT_FILE = $MyInvocation.MyCommand.Source
# Rice global configs
$global:RICE_CONFIGS = @{
#    theme = "style_std"
#    modules = @("test")
}
RiceConfigInit
#endregion
