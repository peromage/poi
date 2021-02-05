<#
.SYNOPSIS
Rice root module. Initialization will be done in this module.
Modified by peromage on 2012/01/24
#>

param ([hashtable]$configs=@{})

#region Global variables

# Environment variables
$global:rice_user_env_vars = @{
XDG_DATA_HOME = Join-Path $HOME ".local/share"
XDG_CONFIG_HOME = Join-Path $HOME ".config"
XDG_CACHE_HOME = Join-Path $HOME ".cache"
EDITOR = "nvim"
SHELL = "pwsh"
}

# Default configurations
$global:rice_configs = @{
# CLI prompt theme
theme = ""
# Additional plugins
plugins = @()
}

#endregion

#region Global status meta

$global:rice_meta = @{
HostName = $ENV:COMPUTERNAME
UserName = $ENV:USERNAME
Privileged = $false
PathSeparator = ";"
RootDir = $PSScriptRoot
}
# Update based on the platform
if ($IsWindows) {
    $global:rice_meta.Privileged = (
        [Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(
            [Security.Principal.WindowsBuiltinRole]::Administrator
    )
} elseif ($IsLinux) {
    $global:rice_meta.HostName = hostname
    $global:rice_meta.Privileged = (id -u) -eq 0
    $global:rice_meta.PathSeparator = ":"
}

#endregion

#region Internal helper functions

function script:buildFileSourcingString {
    <#
    .SYNOPSIS
    This function returns a string which can be used to source the given file
    in current scope.
    #>
    param ([string]$path)

    # Normal dot-sourcing version
    return '. "{0}"' -f $path

    # Alternative faster version
    # return '. ([scriptblock]::Create([System.IO.File]::ReadAllText("{0}", [System.Text.Encoding]::UTF8)))' -f $path

    # Alternative faster version 2
    # return '$ExecutionContext.InvokeCommand.InvokeScript($false, ([scriptblock]::Create([System.IO.File]::ReadAllText("{0}", [System.Text.Encoding]::UTF8))), $null, $null)' -f $path
}

function script:buildDirectorySourcingString {
    <#
    .SYNOPSIS
    This function returns a string which can be used to source the given directory
    within this module in current scope.
    #>
    param ([string]$dir, [string]$namePattern)
    return @'
try {{
    $files = Get-ChildItem -Path "{0}" -ErrorAction Stop
    foreach ($_ in $files) {{
        Invoke-Expression (buildFileSourcingString $_.FullName)
    }}
}} catch {{
    Write-Output "Error happened while sourcing scripts:"
    Write-Output "$_"
}}
'@ -f (Join-Path $global:rice_meta.RootDir $dir "$namePattern.ps1")
}

function script:normalizePath {
    param ([string]$path)
    return $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath($path)
}

#endregion

#region Initialization

# Avoid using pipe to optimize loading performance
# Update configuration
foreach ($_ in $configs.GetEnumerator()) {
    $global:rice_configs[$_.Key] = $_.Value
}
# Import base scripts
Invoke-Expression (script:buildDirectorySourcingString base *)
if ($IsWindows) {
    Invoke-Expression (script:buildDirectorySourcingString base_win *)
}
# Load additional plugins
if ($global:rice_configs.plugins.Count -ne 0) {
    foreach ($_ in $global:rice_configs.plugins) {
        Invoke-Expression (script:buildDirectorySourcingString plugins $_)
    }
}
# Load theme
if (-not ([string]::IsNullOrWhiteSpace($global:rice_configs.theme))) {
    Invoke-Expression (script:buildDirectorySourcingString themes $global:rice_configs.theme)
}
# Add script path
$pathToBeAdded = script:normalizePath "$PSScriptRoot/scripts"
if (-not ($ENV:Path -match [regex]::Escape($pathToBeAdded))) {
    $ENV:Path += $global:rice_meta.PathSeparator + $pathToBeAdded
}

#endregion
