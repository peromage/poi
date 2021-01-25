function global:prompt {
    $myPwd = { $pwd.Path -replace ([regex]::Escape($HOME)+'(.*)'),'~$1' }
    if ($global:rice_meta.Privileged) {
        Write-Host -NoNewline -ForegroundColor Red "! $(&$myPwd)"
    } else {
        Write-Host -NoNewline -ForegroundColor Green "> $(&$myPwd)"
    }
    return " "
}
