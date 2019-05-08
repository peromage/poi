# Control Sequence Introducer
function _CSI_ {
    param($str, $code)
    $ESC = [char]0x1b
    return "$ESC[$code$str$ESC[0m"
}

# substitute home prefix with tilde
function _PWD_HOME_TILDE_ {
    $p = $pwd.Path
    if ($p.ToLower().StartsWith($HOME.ToLower())) { return "~"+$p.Substring($HOME.Length) }
    else { return $p }
}

function _PWD_HOME_TILDE_DIR_ {
    $p = (Get-Item .).BaseName
    if ($p.ToLower() -eq $ENV:USERNAME.ToLower()) { return "~" }
    else { return $p }
}

function _PROMPT_SIMPLE_ {
    param($isadmin)
    if ($isadmin) {
        $Global:PS1 = '"[$(_CSI_ "$ENV:USERNAME" "31m")@${ENV:COMPUTERNAME}:$(_PWD_HOME_TILDE_DIR_)]# "'
        $Host.ui.RawUI.WindowTitle = "Administrator:$ENV:USERNAME@$ENV:COMPUTERNAME"
    }
    else {
        $Global:PS1 = '"[$(_CSI_ "$ENV:USERNAME" "32m")@${ENV:COMPUTERNAME}:$(_PWD_HOME_TILDE_DIR_)]$ "'
        $Host.ui.RawUI.WindowTitle = "$ENV:USERNAME@$ENV:COMPUTERNAME"
    }
}

function PROMPT_SELECTOR {
    param($Style, $IsAdmin)
    switch ($Style) {
        "simple" { _PROMPT_SIMPLE_ $IsAdmin; break }
    }
}