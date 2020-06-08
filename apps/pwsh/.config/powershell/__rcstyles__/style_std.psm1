$username = $ENV:USERNAME
$hostname = if($RC_IS_NT){ $ENV:COMPUTERNAME }else{ hostname }

function prompt {
    if ($RC_IS_SU) {
        Write-Host -NoNewline -ForegroundColor Red "$username@$hostname "
        Write-Host -NoNewline -ForegroundColor White "$(RCPwd)#"
    } else {
        Write-Host -NoNewline -ForegroundColor Green "$username@$hostname "
        Write-Host -NoNewline -ForegroundColor White "$(RCPwd)$"
    }
    return " "
}

Export-ModuleMember -Function prompt
