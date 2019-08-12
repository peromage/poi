function ConvertHashToJsonFile {
    param ($file, $hash)
    $json = ConvertTo-Json $hash
    New-Item -Force $file | Out-Null
    Set-Content $file $json -ErrorAction Stop
}
# Only depth 1 supported
# Will be replaced with powershell 6 built-in method
function ConvertJsonFileToHash {
    param ($file)
    $json = Get-Content -Raw $file -ErrorAction Stop
    $obj = ConvertFrom-Json $json
    $hash = @{}
    foreach ($p in $obj.PSObject.Properties) {
        $hash[$p.Name] = $p.Value
    }
    return $hash
}

function ConvertHashToJson {
    param ($hash)
    $json = ConvertTo-Json $hash
    return $json
}
# Only depth 1 supported
# Will be replaced with powershell 6 built-in method
function ConvertJsonToHash {
    param ($json)
    $obj = ConvertFrom-Json $json
    $hash = @{}
    foreach ($p in $obj.PSObject.Properties) {
        $hash[$p.Name] = $p.Value
    }
    return $hash
}

Export-ModuleMember -Function *