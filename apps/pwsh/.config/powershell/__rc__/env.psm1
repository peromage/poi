##
# Customized environment variable
##

# User environment variables
$vars = @{
XDG_DATA_HOME = Join-Path $HOME ".local/share"
XDG_CONFIG_HOME = Join-Path $HOME ".config"
XDG_CACHE_HOME = Join-Path $HOME ".cache"
EDITOR = "nvim"
SHELL = "pwsh"
}

# Only define these functions for NT systems
if ($RC_IS_NT) {
# Function that set the user global environment variable
# Note: Only works for NT systems
function SetUserGlobalEnv {
    foreach ($i in $vars.GetEnumerator()) {
        [System.Environment]::SetEnvironmentVariable($i.Key, $i.Value, "User")
    }
}

# Function that unset the user global environment variable
# Note: Only works for NT systems
function UnsetUserGlobalEnv {
    foreach ($i in $vars.GetEnumerator()) {
        [System.Environment]::SetEnvironmentVariable($i.Key, $null, "User")
    }
}
}

# Start set local env variables
$vars.GetEnumerator() | ForEach-Object { Set-Item "ENV:$($_.key)" $_.Value }

Export-ModuleMember -Function *
