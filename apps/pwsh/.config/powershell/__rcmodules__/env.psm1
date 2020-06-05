<# This script should only be run once #>
$setenv = { [System.Environment]::SetEnvironmentVariable($args[0], $args[1], "User") }
&$setenv "XDG_DATA_HOME" "$HOME\.local\share"
&$setenv "XDG_CONFIG_HOME" "$HOME\.config"
&$setenv "XDG_CACHE_HOME" "$HOME\.cache"

Remove-Variable setenv
