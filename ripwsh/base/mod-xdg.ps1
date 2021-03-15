<###############################################################################

.SYNOPSIS
XDG environment variable setup for the session

Created by peromage 2021/03/05
Last modified 2021/03/05

###############################################################################>

$env:XDG_DATA_HOME = Join-Path $HOME ".local/share"
$env:XDG_CONFIG_HOME = Join-Path $HOME ".config"
$env:XDG_CACHE_HOME = Join-Path $HOME ".cache"
