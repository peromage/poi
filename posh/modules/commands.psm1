function touch {
    if($args[0]) {
        New-Item -ItemType File -Path $args[0]
    } else {
        "Usage: touch <file[,file1[,file2...]]>"
    }
}

function vim {
    if($args.Length -eq 0) {
        bash -c "vim"
    } else {
        bash -c "vim $($args[0].Replace("\", "/"))"}
    }

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

function linktopath {
    [CmdletBinding(PositionalBinding=$false)]
    param([Parameter(Position=0)]$target,
          $name=(Get-Item $target).Name,
          $binpath="$HOME\.local\bin")
    New-Item -ItemType SymbolicLink `
             -Target $target `
             -Path $binpath `
             -Name $name `
             -Force
}
