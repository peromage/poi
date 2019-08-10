function Test-Administrator {
    $ADMIN = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()`
        ).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
    return $ADMIN
}

function sudo {
    if (Test-Administrator) {
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
    if (Test-Administrator) {
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

function RiceModule([switch]$Load, [switch]$Global, [switch]$Unload, [switch]$List, [switch]$FullPath, $mod) {
    if ($List) {
        Write-Output "Available Rice modules:`n======================="
        Get-ChildItem $PSScriptRoot | Where-Object {$_.Name.EndsWith('.psm1')} | ForEach-Object {$_.BaseName}
        return
    }
    if ($Load) {
        $path = ""
        if ($FullPath) {
            $path = $mod
        }
        else {
            $path = Join-Path $PSScriptRoot "$mod.psm1"
        }
        if (Test-Path $path) {
            if ($Global) {
                Import-Module -Global $path
            }
            else {
                Import-Module $path
            }
            return
        }
        Write-Output "No such module found: $path"
        return
    }
    if ($Unload) {
        try {
            Remove-Module $mod -ErrorAction Stop | Out-Null
        } catch {
            Write-Output "Could not unload module $mod"
        }
        return
    }
}

Export-ModuleMember -Function *