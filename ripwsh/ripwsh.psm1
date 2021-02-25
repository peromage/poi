<###############################################################################

.SYNOPSIS
Rice root module. Initialization will be done in this module.

Created by peromage 2021/02/24
Last modified 2021/02/24

###############################################################################>

param([hashtable]$config=@{})

<#------------------------------------------------------------------------------
Default config variables
------------------------------------------------------------------------------#>
# Default configurations
$global:ri_config = @{

    # CLI prompt theme
    theme = ""

    # Additional plugins
    plugins = @()

}
# Update based on passed-in config
foreach ($_ in $config.GetEnumerator()) {
    $ri_config[$_.Key] = $_.Value
}

<#------------------------------------------------------------------------------
Meta
------------------------------------------------------------------------------#>
$global:ri_meta = @{
    HostName = $ENV:COMPUTERNAME
    UserName = $ENV:USERNAME
    Privileged = $false
    PathSeparator = ";"
    Home = $PSScriptRoot
}
# Update based on the platform
if ($IsWindows) {
    $ri_meta.Privileged = (
        [Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(
            [Security.Principal.WindowsBuiltinRole]::Administrator
    )
} elseif ($IsLinux) {
    $ri_meta.HostName = hostname
    $ri_meta.Privileged = (id -u) -eq 0
    $ri_meta.PathSeparator = ":"
}

<#------------------------------------------------------------------------------
Helper functions
------------------------------------------------------------------------------#>
# This is faster than the trivial sourcing
# In order to source the script in current scope, source the returned scriptblock
function source_script {
    param([string]$rel_path)
    $abs_path = Join-Path $ri_meta.Home $rel_path
    return [scriptblock]::Create([System.IO.File]::ReadAllText($abs_path, [System.Text.Encoding]::UTF8))
}

# Just normalize the given path. No file checks
function normalize_path {
    param([string]$path)
    return $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath($path)
}

<#------------------------------------------------------------------------------
Initialization
------------------------------------------------------------------------------#>
# Sourcing base scripts
. (source_script base/common.ps1)
if ($IsWindows) {
    . (source_script base/windows.ps1)
}

# Load additional plugins
$ri_config.plugins | ForEach-Object { . (source_script plugins/$_.ps1) }

# Load theme
if (-not ([string]::IsNullOrWhiteSpace($ri_config.theme))) { . (source_script themes/$($ri_config.theme).ps1) }

# Add script path
$pathToBeAdded = normalize_path "$PSScriptRoot/scripts"
if (-not ($ENV:Path -match [regex]::Escape($pathToBeAdded))) {
    $ENV:Path += $ri_meta.PathSeparator + $pathToBeAdded
}
