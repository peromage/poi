##
# This script should only be run once
##

# Since the APIs are based on the NT system. Don't load them on Unix platforms.
if (-not $RC_IS_NT) { return }

# Set a command to configure environment variable
$setenv = { [System.Environment]::SetEnvironmentVariable($args[0], $args[1], "User") }

&$setenv "XDG_DATA_HOME" "$HOME\.local\share"
&$setenv "XDG_CONFIG_HOME" "$HOME\.config"
&$setenv "XDG_CACHE_HOME" "$HOME\.cache"

Remove-Variable setenv
