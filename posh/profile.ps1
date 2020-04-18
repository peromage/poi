<# This script should only be run once #>
Import-Module -Scope Local "$PSScriptRoot\rcore.psm1"
setvar "XDG_DATA_HOME" "$HOME\.local\share"
setvar "XDG_CONFIG_HOME" "$HOME\.config"
setvar "XDG_CACHE_HOME" "$HOME\.cache"
