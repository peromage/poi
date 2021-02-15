<#
.SYNOPSIS
Environment variable setup for the session
Modified by peromage on 2012/02/15
#>

foreach ($_ in @{

XDG_DATA_HOME = Join-Path $HOME ".local/share"
XDG_CONFIG_HOME = Join-Path $HOME ".config"
XDG_CACHE_HOME = Join-Path $HOME ".cache"
EDITOR = "nvim"
SHELL = "pwsh"

}.GetEnumerator()) {
    Set-Item "ENV:$($_.Key)" $_.Value
}
