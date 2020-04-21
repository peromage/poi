# Common functions
function Show-Dir {
    [CmdletBinding(PositionalBinding=$false, DefaultParameterSetName="sortByDefault")]
    param(
        [Parameter(Position=0)][string]$path=$PWD.Path,
        [Parameter(Mandatory=$false, ParameterSetName="sortByWriteTime")][switch]$write,
        [Parameter(Mandatory=$false, ParameterSetName="sortByAccessTime")][switch]$access,
        [Parameter(Mandatory=$false, ParameterSetName="sortByCreationTime")][switch]$creation,
        [Parameter(Mandatory=$false, ParameterSetName="sortByName")][switch]$name,
        [Parameter(Mandatory=$false, ParameterSetName="sortBySize")][switch]$size
    )
    if ($write) {
        Get-ChildItem $path `
        | Sort-Object LastWriteTime `
        | Select-Object Mode,Length,LastWriteTime,Name,Target `
        | Format-Table -AutoSize
    } elseif ($access) {
        Get-ChildItem $path `
        | Sort-Object LastAccessTime `
        | Select-Object Mode,Length,LastAccessTime,Name,Target `
        | Format-Table -AutoSize
    } elseif ($creation) {
        Get-ChildItem $path `
        | Sort-Object CreationTime `
        | Select-Object Mode,Length,CreationTime,Name,Target `
        | Format-Table -AutoSize
    } elseif ($name) {
        Get-ChildItem $path `
        | Sort-Object Name `
        | Select-Object Mode,Length,LastWriteTime,Name,Target `
        | Format-Table -AutoSize
    } elseif ($size) {
        Get-ChildItem $path `
        | Sort-Object Length `
        | Select-Object Mode,Length,LastWriteTime,Name,Target `
        | Format-Table -AutoSize
    } else {
        Get-ChildItem $path `
        | Select-Object Mode,Length,LastWriteTime,Name,Target `
        | Format-Table -AutoSize
    }
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
