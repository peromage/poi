<#
.SYNOPSIS
Rice root module. Initialization will be done in this module.
Modified by peromage on 2012/01/24
#>

#region Global variables
# Environment variables
$global:rice_user_env_vars = @{
XDG_DATA_HOME = Join-Path $HOME ".local/share"
XDG_CONFIG_HOME = Join-Path $HOME ".config"
XDG_CACHE_HOME = Join-Path $HOME ".cache"
EDITOR = "nvim"
SHELL = "pwsh"
}

# General configurations
$global:rice_configs = @{
# CLI prompt theme
Theme = ""
# Additional features
Features = @()
}
#endregion

#region Global status meta
$global:rice_meta = @{
HostName = $ENV:COMPUTERNAME
UserName = $ENV:USERNAME
Privileged = $false
}
if ($IsWindows) {
    $global:rice_meta.Privileged = (
        [Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(
            [Security.Principal.WindowsBuiltinRole]::Administrator
    )
} elseif ($IsLinux) {
    $global:rice_meta.HostName = hostname
    $global:rice_meta.Privileged = (id -u) -eq 0
}
#endregion

#region Internal helper functions
# Function to source all given script files
function script:sourceScripts {
    param ([string]$path)
    . $path

    # Alternative faster version
    # . (
    #     [scriptblock]::Create(
    #         [System.IO.File]::ReadAllText(
    #             $path, [System.Text.Encoding]::UTF8
    #         )
    #     )
    # )

    # Alternative faster version 2
    # $ExecutionContext.InvokeCommand.InvokeScript(
    #     $false,
    #     (
    #         [scriptblock]::Create(
    #             [System.IO.File]::ReadAllText(
    #                 $path, [System.Text.Encoding]::UTF8
    #             )
    #         )
    #     ),
    #     $null,
    #     $null
    # )
}

# Function to source ps1 files under a directory within this module
function script:sourceDirectory {
    param ([string]$dir, [string]$namePattern)
    try {
        $files = Get-ChildItem -Path "$PSScriptRoot\$dir\$namePattern.ps1" -ErrorAction Stop
        foreach ($_ in $files) {
            script:sourceScripts $_.FullName
        }
    } catch {
        Write-Output "Error happened while sourcing scripts:"
        Write-Output "$_"
    }

}

function script:loadBase {
    script:sourceDirectory base *
    # Import Windows related scripts
    if ($IsWindows) {
        script:sourceDirectory base_win *
    }
}

function script:loadFeatures {
    param ([string[]]$names)
    if ($names.Count -eq 0) {
        return
    }
    foreach ($_ in $names) {
        script:sourceDirectory features $_
    }
}

function script:loadTheme {
    param ([string]$name)
    if ([string]::IsNullOrWhiteSpace($name)) {
        return
    }
    script:sourceDirectory themes $name
}

function script:addScriptPath {
    if ($IsWindows) {
        $ENV:Path += ";$PSScriptRoot\scripts"
    } else {
        $ENV:Path += ":$PSScriptRoot/scripts"
    }
}
#endregion

#region Initialization
function Initialize-Rice {
    # Import base scripts
    script:loadBase
    # Load additional features
    script:loadFeatures $global:rice_configs.Features
    # Load theme
    script:loadTheme $global:rice_configs.Theme
    # Add script path
    script:addScriptPath
}
#endregion
