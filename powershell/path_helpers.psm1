function Add-EnvUserPath($path) {
    
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
    Set-EnVUserPath $currPath
}

function Remove-EnvUserPath($path) {
    
    if (-not (Test-EnvUserPath $path)) {
        return
    }
    
    $currPath = Get-EnvUserPath
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
    Set-EnVUserPath $newPath
}

function Test-EnvUserPath($path) {
    
    $currPath = Get-EnvUserPath
    $arr = $currPath.Split(';')
    foreach ($i in $arr) {
        if ($i.EndsWith($path)) {
            return $true
        }
    }
    return $false
}

function Get-EnvUserPath {
    $path = [System.Environment]::GetEnvironmentVariable("path", [System.EnvironmentVariableTarget]::User)
    if ($path -eq $null) {
        return ""
    }
    return $path
}

function Set-EnVUserPath($path) {
    
    if (-not $path.EndsWith(";")) {
        $path = $path + ";"
    }
    
    [System.Environment]::SetEnvironmentVariable("path", $path, [System.EnvironmentVariableTarget]::User)
}

Export-ModuleMember -Function *