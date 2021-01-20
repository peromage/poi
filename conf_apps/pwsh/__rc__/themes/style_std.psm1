if ($IsWindows) {
    $hostname = $ENV:COMPUTERNAME
    $issu = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(
        [Security.Principal.WindowsBuiltinRole]::Administrator)
} else {
    $hostname = hostname
    $issu = (id -u) -eq 0
}
$username = $ENV:USERNAME
function StylishPwd {
    return [string]$pwd -replace ([regex]::Escape($HOME)+'(.*)'),'~$1'
}

function global:prompt {
    if ($issu) {
        Write-Host -NoNewline -ForegroundColor Red "$username@$hostname "
        Write-Host -NoNewline -ForegroundColor White "$(StylishPwd)#"
    } else {
        Write-Host -NoNewline -ForegroundColor Green "$username@$hostname "
        Write-Host -NoNewline -ForegroundColor White "$(StylishPwd)$"
    }
    return " "
}

Export-ModuleMember -Function prompt
