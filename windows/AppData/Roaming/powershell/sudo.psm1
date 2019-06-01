function sudo()
{
    if ($args.Length -eq 0)
    {
        Write-Output "At least one parameter."
    }
    if ($args.Length -ge 1)
    {
        $commands = "-command cd $pwd;"
        $commands = "-noexit " + $commands
        $commands = $commands +  ($args -join ' ')
        start-process "powershell" -ArgumentList $commands
    }
}

Export-ModuleMember -Function sudo