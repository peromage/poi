$ADMIN = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()`
    ).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)

$MyBin = @{
    "7z.exe" = "7-zip\7zFM.exe"
    "aria2.exe" = "aria2\aria2c.exe"
    "git.exe" = "git\bin\git.exe"
    "bash.exe" = "git\bin\bash.exe"
    "jcp.exe" = "jcpicker\jcpicker.exe"
    "picpick.exe" = "picpick\picpick.exe"
    "vnc.exe" = "vncviewer\vncviewer.exe"
    "tc.exe" = "totalcommander\TOTALCMD64.EXE"
    "code.cmd" = "vscode\bin\code.cmd"
    "vlc.exe" = "vlc\vlc.exe"
}

function Install-MyBin {
    param (
        $BinPath = $pwd.Path,
        $TargetPath = $pwd.Path
    )

    if ($ADMIN) {
        foreach ($b in $MyBin.GetEnumerator())
        {
            $link = Join-Path $BinPath $b.Name
            $target = Join-Path $TargetPath $b.Value
            $parent = Split-Path -Parent $target
            if (-not (Test-Path $target))
            {
                if (-not (Test-Path $parent)) { New-Item -ItemType Directory $parent | Out-Null }
                New-Item -ItemType File $target | Out-Null
            }
            New-Item -ItemType SymbolicLink -Force -Path $link -Value $target | Out-Null
        }
        Write-Output "Done."
    }
    else {
        Write-Output "To continue, run as admin."
    }
}

Export-ModuleMember -Function Install-MyBin