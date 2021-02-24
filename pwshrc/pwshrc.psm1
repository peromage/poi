<###############################################################################

.SYNOPSIS
Rice root module. Initialization will be done in this module.

Created by peromage 2021/02/24
Last modified 2021/02/24

###############################################################################>

param([hashtable]$configs=@{})

<#------------------------------------------------------------------------------
Default config variables
------------------------------------------------------------------------------#>
# Default configurations
$global:rice_configs = @{

    # CLI prompt theme
    theme = ""

    # Additional plugins
    plugins = @()

}
# Update based on passed-in configs
foreach ($_ in $configs.GetEnumerator()) {
    $rice_configs[$_.Key] = $_.Value
}

<#------------------------------------------------------------------------------
Meta
------------------------------------------------------------------------------#>
$global:rice_meta = @{
    HostName = $ENV:COMPUTERNAME
    UserName = $ENV:USERNAME
    Privileged = $false
    PathSeparator = ";"
    Home = $PSScriptRoot
}
# Update based on the platform
if ($IsWindows) {
    $rice_meta.Privileged = (
        [Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(
            [Security.Principal.WindowsBuiltinRole]::Administrator
    )
} elseif ($IsLinux) {
    $rice_meta.HostName = hostname
    $rice_meta.Privileged = (id -u) -eq 0
    $rice_meta.PathSeparator = ":"
}

<#------------------------------------------------------------------------------
Helper functions
------------------------------------------------------------------------------#>
# This is faster than the trivial sourcing
# In order to source the script in current scope, source the returned scriptblock
function source_script {
    param([string]$rel_path)
    $abs_path = Join-Path $rice_meta.Home $rel_path
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
$rice_configs.plugins | ForEach-Object { . (source_script plugins/$_.ps1) }

# Load theme
if (-not ([string]::IsNullOrWhiteSpace($rice_configs.theme))) { . (source_script themes/$($rice_configs.theme).ps1) }

# Add script path
$pathToBeAdded = normalize_path "$PSScriptRoot/scripts"
if (-not ($ENV:Path -match [regex]::Escape($pathToBeAdded))) {
    $ENV:Path += $rice_meta.PathSeparator + $pathToBeAdded
}
