##
## Created by peromage on 2020/02/17
##

param([string]$prompt_style="myprompt")

# Guard repeat loading
if ($null -ne $RCINIT) {
    Write-Output "RC already loaded"
    return
} else {
    $RCINIT = 1
}

$RCROOT = $PSScriptRoot

# Module loader
function RCLoad {
    <#
    $path: Folder where the module resides
    $modlist: Module name list
    Note: modlist supports glob
    #>
    param([string]$path, [string[]]$modlist, [string]$extension=".psm1")
    $modlist | ForEach-Object {
        Get-ChildItem -Path "$path/$_$extension" `
        | ForEach-Object { Import-Module -Scope Global -DisableNameChecking -Name $_.FullName }
    }
}

# Local module loader. Modules in __rcmodules__ will be uses
function RCLoadModule {
    param([string]$name)
    Import-Module -Scope Global -DisableNameChecking -Name "$RCROOT/__rcmodules__/$name.psm1"
}


function RCInit {
    # Loading modules
    RCLoad "$RCROOT\__rc__" *
    # Loading prompt
    RCLoad "$RCROOT\__rcstyles__" $prompt_style
}

RCInit
