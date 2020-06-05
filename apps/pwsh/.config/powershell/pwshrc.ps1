##
## Created by peromage on 2020/02/17
##

param([string]$prompt_style="myposh")

# Guard repeat loading
if ($null -ne $RCINIT) {
    Write-Output "RC already loaded"
    return
} else {
    $RCINIT = 1
}

# Module loader
function RCLoadModule {
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

$RCROOT = $PSScriptRoot

function RCInit {
    # Loading modules
    RCLoadModule "$RCROOT\__rc__" *
    # Loading prompt
    RCLoadModule "$RCROOT\__rcstyles__" $prompt_style
}

RCInit
