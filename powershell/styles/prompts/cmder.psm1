function _PROMPT_CMDER_ {
    if (Test-Administrator) {
        $Script:PS1 = '" $ESC[31m$pwd$ESC[0m`n !> "'
        $Host.ui.RawUI.WindowTitle = "Administrator:$ENV:USERNAME@$ENV:COMPUTERNAME"
    }
    else {
        $Script:PS1 = '" $ESC[32m$pwd$ESC[0m`n > "'
        $Host.ui.RawUI.WindowTitle = "$ENV:USERNAME@$ENV:COMPUTERNAME"
    }
}