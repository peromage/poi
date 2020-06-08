##
## Created by peromage on 2020/02/17
## Last modified: 2020/06/07
##

# Arguments give rc ability to be customizable
param([string]$style="style_std")

##
# Automatic variables from rc
#
# Guard repeat loading
if ($null -ne $global:RC_HAS_INIT) {
    Write-Output "RC already loaded"
    return
} else {
    $global:RC_HAS_INIT = 1
}
# RC root directory
$global:RC_ROOT = $PSScriptRoot
# Current platform: Windows or Unix
$global:RC_IS_NT = if($IsWindows -or $ENV:OS){ $true }else{ $false }
# Current user privilege
$global:RC_IS_SU = &{
    if ($RC_IS_NT) {
        return ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent() `
               ).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator) 
    } else {
        return (id -u) -eq 0
    }
}

##
# Module loader
# @$path: Folder where the module resides
# @$modlist: Module name list
# @$extension: module type
# Note: modlist supports glob
function global:RCLoad {
    param([string]$path, [string[]]$modlist, [string]$extension=".psm1")
    $modlist | ForEach-Object {
        Get-ChildItem -Path "$path/$_$extension" `
        | ForEach-Object { Import-Module -Scope Global -DisableNameChecking -Name $_.FullName }
    }
}

# Local module loader. Modules in __rcmodules__ will be uses
function global:RCLoadModule {
    param([string]$name)
    Import-Module -Scope Global -DisableNameChecking -Name "$RC_ROOT/__rcmodules__/$name.psm1"
}

# Get current path. Replace home with tilde.
function global:RCPwd {
    return [string]$pwd -replace ([regex]::Escape($HOME)+'(.*)'),'~$1'
}

# Initialization function
function global:RCInit  {
    # Loading modules
    RCLoad "$RC_ROOT/__rc__" *
    # Loading prompt
    RCLoad "$RC_ROOT/__rcstyles__" $style
    # Load NT modules
    if ($RC_IS_NT) {
        RCLoadModule "nt_admin"
    }
}

RCInit
