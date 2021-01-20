<#
.SYNOPSIS
Global variable related.
Modified by peromage on 2021/01/2-
#>

# User environment variables
$UserEnvVars = @{
XDG_DATA_HOME = Join-Path $HOME ".local/share"
XDG_CONFIG_HOME = Join-Path $HOME ".config"
XDG_CACHE_HOME = Join-Path $HOME ".cache"
EDITOR = "nvim"
SHELL = "pwsh"
}

# Funtions for Windows only
if ($IsWindows) {

# User global env variables related
function SetUserEnvVars {
    param ($envVarHash)
    foreach ($_ in $envVarHash.GetEnumerator()) {
        [System.Environment]::SetEnvironmentVariable(
            $_.Key, $_.Value, [System.EnvironmentVariableTarget]::User)
    }
}

function UnsetUserEnvVars {
    param ($envVarHash)
    foreach ($_ in $envVarHash.GetEnumerator()) {
        [System.Environment]::SetEnvironmentVariable(
            $_.Key, $null, [System.EnvironmentVariableTarget]::User)
    }
}

# User global env path related
function GetUserEnvPath {
    $path = [System.Environment]::GetEnvironmentVariable(
        "Path", [System.EnvironmentVariableTarget]::User)
    if ($null -eq $path) {
        return ""
    }
    return $path
}

function UpdateSessionEnvPath {
    $env:Path = @(
        [System.Environment]::GetEnvironmentVariable(
            "Path", [System.EnvironmentVariableTarget]::Machine),
        [System.Environment]::GetEnvironmentVariable(
            "Path", [System.EnvironmentVariableTarget]::User)) -join ";"
}

function SetUserEnvPath {
    param ($path)
    if (-not $path.EndsWith(";")) {
        $path = $path + ";"
    }
    [System.Environment]::SetEnvironmentVariable(
        "Path", $path, [System.EnvironmentVariableTarget]::User)
    UpdateSessionEnvPath
}

function TestUserEnvPath {
    param ($path)
    $currPath = GetUserEnvPath
    $arr = $currPath.Split(';')
    foreach ($_ in $arr) {
        if ($_.EndsWith($path)) {
            return $true
        }
    }
    return $false
}

function AddUserEnvPath {
    param ($path)
    if (TestUserEnvPath $path) {
        return
    }
    if (-not $path.EndsWith(";")) {
        $path = $path + ";"
    }
    $currPath = GetUserEnvPath
    if (-not $currPath.EndsWith(";")) {
        $currPath = $currPath + ";"
    }
    $currPath = $currPath + $path
    SetUserEnvPath $currPath
}

function RemoveUserEnvPath {
    param ($path)
    if (-not (TestUserEnvPath $path)) {
        return
    }
    $currPath = GetUserEnvPath
    $arr = $currPath.Split(';')
    $newPath = ""
    foreach ($_ in $arr) {
        if ($_.EndsWith($path)) {
            continue
        }
        if ($_ -eq "") {
            continue
        }
        $newPath = $newPath + $_ + ";"
    }
    SetUserEnvPath $newPath
}

# Admin related
function TestAdmin {
    return ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(
        [Security.Principal.WindowsBuiltinRole]::Administrator)
}

function RunAsAdmin {
    if (TestAdmin) {
        Write-Output "Already as admin!"
    } else {
        if ($args.Length -eq 0) {
            Write-Output "Usage: sudo <command> [arguments]"
        } elseif ($args.Length -ge 1) {
            $commands = "-noexit -command cd $pwd;" + ($args -join ' ')
            $proc = New-Object -TypeName System.Diagnostics.Process
            $proc.StartInfo.FileName = "powershell.exe"
            $proc.StartInfo.Arguments = $commands
            $proc.StartInfo.UseShellExecute = $true
            $proc.StartInfo.Verb = "runas"
            $proc.Start() | Out-Null
        }
    }
}

function EvalToAdmin {
    if (TestAdmin) {
        Write-Output "Already as admin!"
    } else {
        $commands = "-noexit -command cd $pwd;"
        $proc = New-Object -TypeName System.Diagnostics.Process
        $proc.StartInfo.FileName = "powershell.exe"
        $proc.StartInfo.Arguments = $commands
        $proc.StartInfo.UseShellExecute = $true
        $proc.StartInfo.Verb = "runas"
        $proc.Start() | Out-Null
    }
}

}

# Export to current session
function ExportUserEnvVarsToSession {
    foreach ($_ in $UserEnvVars.GetEnumerator()) {
        Set-Item "ENV:$($_.key)" $_.Value
    }
}

Export-ModuleMember -Function * -Variable UserEnvVars
