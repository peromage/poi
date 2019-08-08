$DEFAULT_PATH = Join-Path -Path $HOME -ChildPath ".local\bin"

$MyBin = @{
    "7z" = "7-zip\7zFM.exe"
    "aria2" = "aria2\aria2c.exe"
    "git" = "git\bin\git.exe"
    "bash" = "git\bin\bash.exe"
    "jcp" = "jcpicker\jcpicker.exe"
    "picpick" = "picpick\picpick.exe"
    "vnc" = "vncviewer\vncviewer.exe"
    "tc" = "totalcommander\TOTALCMD64.EXE"
    "code" = "vscode\bin\code.cmd"
    "vlc" = "vlc\vlc.exe"
    "chrome" = "chrome\chrome.exe"
    "npp" = "notepad++\notepad++.exe"
}

function Install-SymlinkShims {
    $binPath = GetPathFromPrompt "Binaries path"
    $shimPath = GetPathFromPrompt "Shims path"

    if (Test-Administrator) {
        foreach ($b in $MyBin.GetEnumerator())
        {
            $shim = Join-Path $shimPath ($b.Name + ".exe")
            $bin = Join-Path $binPath $b.Value
            if (-not (Test-Path $bin))
            {
                # set bin placeholder
                New-Item -Force -ItemType File $bin | Out-Null
            }
            # set symlink
            New-Item -ItemType SymbolicLink -Force -Path $shim -Value $bin | Out-Null
        }
        Write-Output "Done."
    }
    else {
        Write-Output "To continue, run as admin."
    }
}

Export-ModuleMember -Function Install-Shims