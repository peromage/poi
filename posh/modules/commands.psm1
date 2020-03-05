function ll {
    Get-ChildItem $args[0] `
    | Select-Object Mode,Length,LastWriteTime,Name,Target `
    | Format-Table -AutoSize
}

function issu {
    $ADMIN = (
        [Security.Principal.WindowsPrincipal] `
        [Security.Principal.WindowsIdentity]::GetCurrent()`
        ).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
    return $ADMIN
}

function sudo {
    if (issu) {
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

function su {
    if (issu) {
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
