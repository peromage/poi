# Common functions
function Show-Dir {
    Get-ChildItem $args[0] `
    | Select-Object Mode,Length,LastWriteTime,Name,Target `
    | Format-Table -AutoSize
}

function Test-Admin {
    $ADMIN = (
        [Security.Principal.WindowsPrincipal] `
        [Security.Principal.WindowsIdentity]::GetCurrent()`
        ).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
    return $ADMIN
}

function Grant-Admin {
    if (Test-Admin) {
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

function Switch-Admin {
    if (Test-Admin) {
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

# Git functions
function Git-Status {
    git status
}

function Git-Log {
    git log --graph --pretty=format:'%Cred%h%Creset [%an] - %s %Cgreen(%ci)%Creset %C(cyan)%d%Creset' --abbrev-commit --date=relative
}

function Git-AddCommit {
    git add -A
    git commit -m $args[0]
}

function Git-Branch {
    git branch $args
}

function Git-Checkout {
    git checkout $args
}


# Alias
Set-Alias -Name ll -Value Show-Dir
Set-Alias -Name issu -Value Test-Admin
Set-Alias -Name sudo -Value Grant-Admin
Set-Alias -Name su -Value Switch-Admin
Set-Alias -Name gst -Value Git-Status
Set-Alias -Name glo -Value Git-Log
Set-Alias -Name gac -Value Git-AddCommit
Set-Alias -Name gch -Value Git-Checkout
Set-Alias -Name gbr -Value Git-Branch

# Exporting
Export-ModuleMember -Function * -Alias *
