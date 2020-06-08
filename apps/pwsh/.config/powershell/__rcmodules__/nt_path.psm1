##
# Path utilities for NT system
##

# Since the APIs are based on the NT system. Don't load them on Unix platforms.
if (-not $RC_IS_NT) { return }

function Add-UserPath {
    param ($path)
    if (Test-UserPath $path) {
        return
    }
    if (-not $path.EndsWith(";")) {
        $path = $path + ";"
    }
    $currPath = Get-UserPath
    if (-not $currPath.EndsWith(";")) {
        $currPath = $currPath + ";"
    }
    $currPath = $currPath + $path
    Set-UserPath $currPath
}

function Remove-UserPath {
    param ($path)
    if (-not (Test-UserPath $path)) {
        return
    }
    $currPath = Get-UserPath
    $arr = $currPath.Split(';')
    $newPath = ""
    foreach ($i in $arr) {
        if ($i.EndsWith($path)) {
            continue
        }
        if ($i -eq "") {
            continue
        }
        $newPath = $newPath + $i + ";"
    }
    Set-UserPath $newPath
}

function Test-UserPath {
    param ($path)
    $currPath = Get-UserPath
    $arr = $currPath.Split(';')
    foreach ($i in $arr) {
        if ($i.EndsWith($path)) {
            return $true
        }
    }
    return $false
}

function Get-UserPath {
    $path = [System.Environment]::GetEnvironmentVariable(
        "path", [System.EnvironmentVariableTarget]::User)
    if ($null -eq $path) {
        return ""
    }
    return $path
}

function Set-UserPath {
    param ($path)
    if (-not $path.EndsWith(";")) {
        $path = $path + ";"
    }
    [System.Environment]::SetEnvironmentVariable(
        "path", $path, [System.EnvironmentVariableTarget]::User)
    Update-EnvPath
}

function Update-EnvPath {
    $env:Path = @(
        [System.Environment]::GetEnvironmentVariable(
            "path", [System.EnvironmentVariableTarget]::Machine),
        [System.Environment]::GetEnvironmentVariable(
            "path", [System.EnvironmentVariableTarget]::User)) -join ";"
}
