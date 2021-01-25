<#
.SYNOPSIS
User global environment path related. Modifications will be persistent.
Modified by peromage on 2021/01/24
#>

function Get-EnvUserPath {
    $path = [System.Environment]::GetEnvironmentVariable(
        "Path", [System.EnvironmentVariableTarget]::User)
    if ($null -eq $path) {
        return ""
    }
    return $path
}

function Update-SessionEnvPath {
    $env:Path = @(
        [System.Environment]::GetEnvironmentVariable(
            "Path", [System.EnvironmentVariableTarget]::Machine),
        [System.Environment]::GetEnvironmentVariable(
            "Path", [System.EnvironmentVariableTarget]::User)) -join ";"
}

function Set-EnvUserPath {
    param ($path)
    if (-not $path.EndsWith(";")) {
        $path = $path + ";"
    }
    [System.Environment]::SetEnvironmentVariable(
        "Path", $path, [System.EnvironmentVariableTarget]::User)
    Update-SessionEnvPath
}

function Test-EnvUserPath {
    param ($path)
    $currPath = Get-EnvUserPath
    $arr = $currPath.Split(';')
    foreach ($_ in $arr) {
        if ($_.EndsWith($path)) {
            return $true
        }
    }
    return $false
}

function Add-EnvUserPath {
    param ($path)
    if (Test-EnvUserPath $path) {
        return
    }
    if (-not $path.EndsWith(";")) {
        $path = $path + ";"
    }
    $currPath = Get-EnvUserPath
    if (-not $currPath.EndsWith(";")) {
        $currPath = $currPath + ";"
    }
    $currPath = $currPath + $path
    Set-EnvUserPath $currPath
}

function Remove-EnvUserPath {
    param ($path)
    if (-not (Test-EnvUserPath $path)) {
        return
    }
    $currPath = Get-EnvUserPath
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
    Set-EnvUserPath $newPath
}
