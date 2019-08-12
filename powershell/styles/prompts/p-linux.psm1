$_PS1 = ""
$_TITLE = ""
$ESC = [char]0x1b
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

if (TestAdmin) {
    $_PS1 = '"[$ESC[31m${ENV:USERNAME}$ESC[0m@${ENV:COMPUTERNAME}:$(_PWD_HOME_TILDE_DIR_)]# "'
    $_TITLE = "Administrator:$ENV:USERNAME@$ENV:COMPUTERNAME"
}
else {
    $_PS1 = '"[$ESC[32m${ENV:USERNAME}$ESC[0m@${ENV:COMPUTERNAME}:$(_PWD_HOME_TILDE_DIR_)]$ "'
    $_TITLE = "$ENV:USERNAME@$ENV:COMPUTERNAME"
}

function PSPrompt {
    $Host.ui.RawUI.WindowTitle = $_TITLE
    return Invoke-Expression $_PS1
}

Export-ModuleMember -Function PSPrompt