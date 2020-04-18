function LoadModule {
    <#
    $path: Folder where the module resides
    $modlist: Module name list
    Note: modlist supports glob
    #>
    param([string]$path, [array]$modlist, [string]$extension=".psm1")
    foreach ($i in $modlist) {
        $mp = "$path\$i$extension"
        $ml = Get-Item -Path $mp
        if ($null -eq $ml) {
            Write-Output "Module not found: $mp"
            continue
        }
        foreach ($m in $ml) {
            Import-Module -Scope Global -DisableNameChecking -Name $m.FullName
        }
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
