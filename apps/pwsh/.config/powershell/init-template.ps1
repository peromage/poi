#######################################
## Created by peromage on 2020/02/17 ##
#######################################

#region User Configurations

#$RC_Prompt_Style = "style_std"
#$RC_Modules = @("nt_admin")

# Uncomment this to enable force reload
#$RC_HAS_INIT = $false

#endregion


################################################################################


#region Initialization Don't touch

# Guard repeat loading
if ($null -ne $global:RC_HAS_INIT) { return }

# RC variables
#
# If RC loaded
$global:RC_HAS_INIT = $true
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

# Module loader
# @$path: Folder where the module resides
# @$modlist: Module name list
# @$extension: module type
# Note: modlist supports glob
function global:RCLoad {
    param([string]$path, [string[]]$modlist, [string]$extension=".psm1")
    $modlist | ForEach-Object {
        $mods = @(Get-ChildItem -Path "${path}/${_}${extension}" `
        | ForEach-Object { $_.FullName })
        Import-Module -Scope Global -DisableNameChecking -Name $mods
    }
}

# Local module loader. Modules in __rcmodules__ will be uses
# Load one module at a time
function global:RCLoadModule {
    param([string]$name)
    global:RCLoad "$RC_ROOT/__rcmodules__" $name
}

# Get current path. Replace home with tilde.
function global:RCPwd {
    return [string]$pwd -replace ([regex]::Escape($HOME)+'(.*)'),'~$1'
}

# Quick edit configuration file
$INIT_FILE = $MyInvocation.MyCommand.Source
function RcConfig {
    if (Test-Path ENV:EDITOR) {
        Invoke-Expression  "$ENV:EDITOR $INIT_FILE"
    } else {
        Write-Host "No ENV:EDITOR found!"
    }
}

# Start Initialization
#
# Loading modules
RCLoad "$RC_ROOT/__rc__" *
# Loading prompt
if ($RC_Prompt_Style) {
    RCLoad "$RC_ROOT/__rcstyles__" $RC_Prompt_Style
}
# Load NT modules
if ($RC_Modules) {
    RCLoad "$RC_ROOT/__rcmodules__" $RC_Modules
}

#endregion
