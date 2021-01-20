if ($IsWindows) {
    $issu = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(
        [Security.Principal.WindowsBuiltinRole]::Administrator)
} else {
    $issu = (id -u) -eq 0
}
function StylishPwd {
    return [string]$pwd -replace ([regex]::Escape($HOME)+'(.*)'),'~$1'
}
function global:prompt {
    if ($issu) {
        Write-Host -NoNewline -ForegroundColor Red "! $(StylishPwd)"
    } else {
        Write-Host -NoNewline -ForegroundColor Green "> $(StylishPwd)"
    }
    return " "
}

Export-ModuleMember -Function prompt
