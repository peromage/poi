$ADMIN = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()`
    ).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)

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

function Test-Administrator {
    return $Script:ADMIN
}

function sudo {
    if ($Script:ADMIN) {
        Write-Output "Already as admin!"
    }
    else {
        if ($args.Length -eq 0)
        {
            Write-Output "Usage: sudo <command> [arguments]"
        }
        elseif ($args.Length -ge 1)
        {
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

function su {
    if ($Script:ADMIN) {
        Write-Output "Already as admin!"
    }
    else {
        $commands = "-noexit -command cd $pwd;"

        $proc = New-Object -TypeName System.Diagnostics.Process
        $proc.StartInfo.FileName = "powershell.exe"
        $proc.StartInfo.Arguments = $commands
        $proc.StartInfo.UseShellExecute = $true
        $proc.StartInfo.Verb = "runas"

        $proc.Start() | Out-Null
    }
}

Export-ModuleMember -Function *