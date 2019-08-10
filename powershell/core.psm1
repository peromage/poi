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

# Only works for Rice modules
function RiceModule([switch]$Load, [switch]$Local, [switch]$Unload, [switch]$List, [string]$mod) {
    if ($List) {
        Write-Output "Available Rice modules:`n======================="
        Get-ChildItem $PSScriptRoot | Where-Object {$_.Name.EndsWith('.psm1')} | ForEach-Object {$_.BaseName}
        return
    }
    # Use relative path to load
    if ($Load) {
        $path = Join-Path $PSScriptRoot "$mod.psm1"
        if (Test-Path $path) {
            if ($Local) {
                Import-Module $path
            }
            else {
                Import-Module -Global $path
            }
            return $true
        }
        else {
            # Write-Output "No such module found: $path"
            return $false
        }
    }
    # Give module name to unload
    if ($Unload) {
        try {
            $loaded = Get-Module -Name $mod -ErrorAction Stop
            if ($loaded.Path.StartsWith($PSScriptRoot)) {
                Remove-Module $loaded.Name
                return $true
            }
            else {
                # Write-Output "Not a Rice Module. Use <Remove-Module> to remove."
                return $false
            }
        }
        catch {
            # Write-Output "Could not unload module $mod"
            return $false
        }
    }
}

Export-ModuleMember -Function *