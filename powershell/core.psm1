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

function RiceModule([switch]$Load, [switch]$Unload, [switch]$List, $mod) {
    if ($List) {
        Write-Host "Available Rice modules:`n======================="
        Get-ChildItem $PSScriptRoot | Where-Object {$_.Name -match "\.psm1$"} | %{$_.BaseName}
        return
    }
    else {
        $path = Join-Path $PSScriptRoot "$mod.psm1"
        if ($Load) {
            if (Test-Path $path) {
                Import-Module -Global $path
                return
            }
            Write-Host -ForegroundColor Red "No such module found: $path"
            return
        }
        if ($Unload) {
            try {
                Remove-Module $mod -ErrorAction Stop | Out-Null
            } catch {
                Write-Host -ForegroundColor Red "Could not unload module $mod"
            }
            return
        }
    }
    
}

Export-ModuleMember -Function *