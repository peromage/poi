<###############################################################################

.SYNOPSIS
Environment variable setup for the session

Created by peromage 2021/02/24
Last modified 2021/02/24

###############################################################################>

foreach ($_ in @{

XDG_DATA_HOME = Join-Path $HOME ".local/share"
XDG_CONFIG_HOME = Join-Path $HOME ".config"
XDG_CACHE_HOME = Join-Path $HOME ".cache"
EDITOR = "nvim"
SHELL = "pwsh"

}.GetEnumerator()) {
    Set-Item "ENV:$($_.Key)" $_.Value
}
