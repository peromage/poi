$ADMIN = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()`
    ).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)

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

function GetPathFromPrompt {
	param($prompt)
	$output = $DEFAULT_PATH
	$input = Read-Host "$prompt ($output)"
	if ($input -ne "") {$output = $input}
	return $output
}

function Install-SymlinkShims {
    $binPath = GetPathFromPrompt "Binaries path"
    $shimPath = GetPathFromPrompt "Shims path"

    if ($Script:ADMIN) {
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

function Install-ScriptShims {
	$binPath = GetPathFromPrompt "Binaries path"
    $shimPath = GetPathFromPrompt "Shims path"
	
    foreach ($b in $MyBin.GetEnumerator())
    {
        $shim = Join-Path $shimPath ($b.Name + ".cmd")
        $bin = Join-Path $binPath $b.Value
        if (-not (Test-Path $bin))
        {
            # set bin placeholder
            New-Item -Force -ItemType File $bin | Out-Null
        }
        # set script
        Set-Content $shim "@call $bin %*"
    }
    Write-Output "Done."
}

Export-ModuleMember -Function Install-ScriptShims, Install-SymlinkShims