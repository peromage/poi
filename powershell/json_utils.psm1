function ConvertHashToJsonFile($hash, $file) {
    $json = ConvertTo-Json $hash
    Set-Content $file $json -ErrorAction Stop
}
# Only depth 1 supported
# Will be replaced with powershell 6 built-in method
function ConvertJsonFileToHash($file) {
    $json = Get-Content -Raw $file -ErrorAction Stop
    $obj = ConvertFrom-Json $json
    $hash = @{}
    foreach ($p in $obj.PSObject.Properties) {
        $hash[$p.Name] = $p.Value
    }
    return $hash
}

function ConvertHashToJson($hash) {
    $json = ConvertTo-Json $hash
    return $json
}
# Only depth 1 supported
# Will be replaced with powershell 6 built-in method
function ConvertJsonToHash($json) {
    $obj = ConvertFrom-Json $json
    $hash = @{}
    foreach ($p in $obj.PSObject.Properties) {
        $hash[$p.Name] = $p.Value
    }
    return $hash
}

Export-ModuleMember -Function *