# substitute home prefix with tilde
function _PWD_HOME_TILDE_ {
    $p = (Get-Item .).FullName
    if ($p.ToLower().StartsWith($HOME.ToLower())) { Write-Output ("~" + $p.Substring($HOME.Length))}
    else { Write-Output $p }
}

function _PWD_HOME_TILDE_DIR_ {
    $p = (Get-Item .).BaseName
    if ($p.ToLower() -eq $ENV:USERNAME.ToLower()) { Write-Output "~" }
    else { Write-Output $p }
}

function PS1 {
    Invoke-Expression $Script:PS1
}

Export-ModuleMember -Function PROMPT_SELECTOR, PS1