<###############################################################################

.SYNOPSIS
Environment variable setup for the session

Created by peromage 2021/02/24
Last modified 2021/02/25

###############################################################################>

$env:XDG_DATA_HOME = Join-Path $HOME ".local/share"
$env:XDG_CONFIG_HOME = Join-Path $HOME ".config"
$env:XDG_CACHE_HOME = Join-Path $HOME ".cache"
$env:EDITOR = "nvim"
$env:SHELL = "pwsh"
