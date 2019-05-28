$MyBin = @{
    "7z.exe" = "7-zip\7zFM.exe"
    "aria2.exe" = "aria2\aria2c.exe"
    "git.exe" = "git\bin\git.exe"
    "bash.exe" = "git\bin\bash.exe"
    "jcp.exe" = "jcpicker\jcpicker.exe"
    "picpick.exe" = "picpick\picpick.exe"
    "vnc.exe" = "vncviewer\vncviewer.exe"
    "tc.exe" = "totalcommander\TOTALCMD64.EXE"
    "vscode.cmd" = "vscode\bin\code.cmd"
}

function Generate-Bin {
    param (
        [string]$BinPath = $pwd.Path,
        [string]$TargetPath = $pwd.Path
    )

    foreach ($b in $MyBin.GetEnumerator())
    {
        $link = Join-Path $BinPath $b.Name
        $target = Join-Path $TargetPath $b.Value
        if (Test-Path $target)
        {
            New-Item -ItemType SymbolicLink -Force -Path $link -Value $target > $null
        }
    }
}