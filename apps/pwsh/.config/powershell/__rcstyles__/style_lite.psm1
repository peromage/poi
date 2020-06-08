function prompt {
    if ($RC_IS_SU) {
        Write-Host -NoNewline -ForegroundColor Red "! $(RCPwd)"
    } else {
        Write-Host -NoNewline -ForegroundColor Green "> $(RCPwd)"
    }
    return " "
}

Export-ModuleMember -Function prompt
