function _PROMPT_SIMPLE_ {
    if (Test-Administrator) {
        $Script:PS1 = '"[$ESC[31m${ENV:USERNAME}$ESC[0m@${ENV:COMPUTERNAME}:$(_PWD_HOME_TILDE_DIR_)]# "'
        $Host.ui.RawUI.WindowTitle = "Administrator:$ENV:USERNAME@$ENV:COMPUTERNAME"
    }
    else {
        $Script:PS1 = '"[$ESC[32m${ENV:USERNAME}$ESC[0m@${ENV:COMPUTERNAME}:$(_PWD_HOME_TILDE_DIR_)]$ "'
        $Host.ui.RawUI.WindowTitle = "$ENV:USERNAME@$ENV:COMPUTERNAME"
    }
}