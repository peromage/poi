function prompt {
    $_PS1 = ""
    $_TITLE = ""
    $ESC = [char]0x1b
    if (issu) {
        $_PS1 = '" $ESC[31m$pwd$ESC[0m`n !> "'
        $_TITLE = "Administrator:$ENV:USERNAME@$ENV:COMPUTERNAME"
    } else {
        $_PS1 = '" $ESC[32m$pwd$ESC[0m`n > "'
        $_TITLE = "$ENV:USERNAME@$ENV:COMPUTERNAME"
    }
    $Host.ui.RawUI.WindowTitle = $_TITLE
    return Invoke-Expression $_PS1
}
