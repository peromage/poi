################################################################################
#
# .SYNOPSIS
# Pwsh initialization template file
#
# Created by peromage 2021/02/24
# Last modified 2021/03/14
#
#
# This section should remain untouched
# Initialization
$init_home = $PSScriptRoot
$init_file = $MyInvocation.MyCommand.Source
$ENV:PSModulePath += [IO.Path]::PathSeparator + $init_home
#
# Examples of configuration outside of ripwsh
#
# z.lua
#------
#iex ((lua54 $init_home\bin\z.lua --init powershell enhanced once) -join "`n")
#
Import-Module ripwsh -ArgumentList @{
#
# Examples of configuration options of ripwsh
#
# Prompt theme
#-------------
#theme = "my_lite"
#
# A list of string for mods under ripwsh/mods
#--------------------------------------------------
#mods = @('basic', 'nav', 'windows', 'env')
#
################################################################################


### Rice config should start before this line ###
}
### Other config should start after this line ###
