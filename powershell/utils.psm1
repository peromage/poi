# Console color test
function Show-ColorTest {
    $width = 7
    $word = "gYm"
    $esc = [char]0x1b
    $palette = @("Black", "DarkRed", "DarkGreen", "DarkYellow", "DarkBlue", "DarkMagenta", "DarkCyan", "Gray" `
        , "DarkGray", "Red", "Green", "Yellow", "Blue", "Magenta", "Cyan", "White", "Faint", "Bold")

    # header
    Write-Host -NoNewline ("{0,$width} {1,$width}" -f "code", "m")
    foreach ($a in 40..47) {
        Write-Host -NoNewline ("{0,$width}" -f "${a}m")
    }
    Write-Host
    # body
    foreach ($i in 29..37) {
        foreach ($j in 0..1) {
            $code = ""
            $name = ""
            if ($i -ge 30) {
                $code = "${j};${i}"
                $name = $palette[$($i-30+$j*8)]
            } 
            else {
                $code = "${j}"
                $name = $palette[-1-$j]
            }
            Write-Host -NoNewline ("{0,$width}" -f "${code}m")
            Write-Host -NoNewline ("{0,$width}" -f $word)
            foreach ($k in 40..47) {
                Write-Host -NoNewline ("$esc[${code};${k}m{0,$width}$esc[0m" -f $word)
            }
            Write-Host (" {1,11} | {0}" -f "$esc[${code}m${name}$esc[0m", $name)
        }
    }
}

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