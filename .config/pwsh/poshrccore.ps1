function LoadModule {
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
function SetVar {
    param([string]$key, [string]$value)
    [System.Environment]::SetEnvironmentVariable($key, $value, [System.EnvironmentVariableTarget]::User)
}

function GetVar {
    param([string]$key)
    return [System.Environment]::GetEnvironmentVariable($key, [System.EnvironmentVariableTarget]::User)
}

function DelVar {
    param([string]$key)
    [System.Environment]::SetEnvironmentVariable($key, $null, [System.EnvironmentVariableTarget]::User)
}
