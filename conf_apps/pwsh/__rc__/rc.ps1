#######################################
## Created by peromage on 2020/08/03 ##
#######################################

# Guard repeat loading
if ($global:RC_HAS_INIT) { return }

# RC variables
#
# If RC loaded
$global:RC_HAS_INIT = $true
# RC root directory
$global:RC_ROOT = $PSScriptRoot
# RC config root directory
$global:RC_CONFIG_ROOT = (Get-Item $PSScriptRoot).Parent.FullName
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
    global:RCLoad "$RC_ROOT/modules" $name
}

# Get current path. Replace home with tilde.
function global:RCPwd {
    return [string]$pwd -replace ([regex]::Escape($HOME)+'(.*)'),'~$1'
}

# Start Initialization
#
# Loading modules
RCLoad "$RC_ROOT/autoload.d" *
# Loading prompt
if ($RC_THEME) {
    RCLoad "$RC_ROOT/themes" $RC_THEME
}
# Load NT modules
if ($RC_Modules) {
    RCLoad "$RC_ROOT/modules" $RC_Modules
}
