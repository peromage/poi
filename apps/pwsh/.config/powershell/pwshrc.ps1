# Author: Fang
# Date: 2020/02/17
param([string]$prompt_style="myposh")

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

# Manipulate user environment variables
function RCSetVar {
    param([string]$key, [string]$value)
    [System.Environment]::SetEnvironmentVariable($key, $value, [System.EnvironmentVariableTarget]::User)
}

function RCGetVar {
    param([string]$key)
    return [System.Environment]::GetEnvironmentVariable($key, [System.EnvironmentVariableTarget]::User)
}

function RCDelVar {
    param([string]$key)
    [System.Environment]::SetEnvironmentVariable($key, $null, [System.EnvironmentVariableTarget]::User)
}

$RCROOT = $PSScriptRoot

function RCInit {
    # Loading modules
    RCLoadModule "$RCROOT\autoload" *
    # Loading prompt
    RCLoadModule "$RCROOT\prompts" $prompt_style
}

RCInit
