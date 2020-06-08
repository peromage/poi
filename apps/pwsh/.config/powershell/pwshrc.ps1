##
## Created by peromage on 2020/02/17
## Last modified: 2020/06/07
##

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

# Make initialization a script block to avoid accidental execution as
# a function or command
$global:RCInit = {
    # Arguments give rc ability to be customizable
    param([string]$prompt_style="myprompt")

    # Loading modules
    RCLoad "$RC_ROOT/__rc__" *
    # Loading prompt
    RCLoad "$RC_ROOT/__rcstyles__" $prompt_style
    # Load NT modules
    if ($RC_IS_NT) {
        RCLoadModule "nt_admin"
    }
}

&$RCInit @args
