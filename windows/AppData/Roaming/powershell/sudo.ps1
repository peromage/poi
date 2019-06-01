function sudo {
    $proc = New-Object -TypeName System.Diagnostics.Process
    $proc.StartInfo.FileName = "powershell.exe"
    $proc.StartInfo.Arguments = "-command cd $home\desktop; . .\dummy.ps1; dummy"
    # $proc.StartInfo.Arguments = "-noexit " + $proc.StartInfo.Arguments
    $proc.StartInfo.RedirectStandardError = $true
    $proc.StartInfo.RedirectStandardOutput = $true
    $proc.StartInfo.RedirectStandardInput = $true
    $proc.StartInfo.UseShellExecute = $false

    $handler = {
        echo $EventArgs.Data
    }

    $job1 = Register-ObjectEvent -InputObject $proc -EventName "ErrorDataReceived" -Action $handler
    $job2 = Register-ObjectEvent -InputObject $proc -EventName "OutputDataReceived" -Action $handler

    $proc.Start() | Out-Null
    echo "starting..."

    $proc.BeginErrorReadLine()
    $proc.BeginOutputReadLine()
    # $proc.WaitForExit()
    while (-not $proc.HasExited) {
        Receive-Job $job1.Name
        Receive-Job $job2.Name
    }
    $job1.StopJob()
    $job2.StopJob()
    Receive-Job $job1.Name
    Receive-Job $job2.Name
    Remove-Job $job1.Name
    Remove-Job $job2.Name
    # $proc.StandardOutput.ReadToEnd()
    # $proc.StandardError.ReadToEnd()
}

sudo