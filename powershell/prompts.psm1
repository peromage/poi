# default style
$PS1 = '"$ENV:USERNAME@${ENV:COMPUTERNAME}:$pwd $ "'
$ADMIN = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()`
    ).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)

# Control Sequence Introducer
function _CSI_ {
    param($str, $code)
    $ESC = [char]0x1b
    Write-Output "$ESC[$code$str$ESC[0m"
}

# substitute home prefix with tilde
function _PWD_HOME_TILDE_ {
    $p = $pwd.Path
    if ($p.ToLower().StartsWith($HOME.ToLower())) { Write-Output "~"+$p.Substring($HOME.Length) }
    else { Write-Output $p }
}

function _PWD_HOME_TILDE_DIR_ {
    $p = (Get-Item .).BaseName
    if ($p.ToLower() -eq $ENV:USERNAME.ToLower()) { Write-Output "~" }
    else { Write-Output $p }
}

function _PROMPT_SIMPLE_ {
    if ($Script:ADMIN) {
        Write-Output '"[$(_CSI_ "$ENV:USERNAME" "31m")@${ENV:COMPUTERNAME}:$(_PWD_HOME_TILDE_DIR_)]# "'
        $Host.ui.RawUI.WindowTitle = "Administrator:$ENV:USERNAME@$ENV:COMPUTERNAME"
    }
    else {
        Write-Output '"[$(_CSI_ "$ENV:USERNAME" "32m")@${ENV:COMPUTERNAME}:$(_PWD_HOME_TILDE_DIR_)]$ "'
        $Host.ui.RawUI.WindowTitle = "$ENV:USERNAME@$ENV:COMPUTERNAME"
    }
}

function PROMPT_SELECTOR {
    param($Style)

    switch ($Style) {
        "simple" { $Script:PS1 = _PROMPT_SIMPLE_; break }
    }
}

function PS1 {
    Invoke-Expression $Script:PS1
}

Export-ModuleMember -Function PROMPT_SELECTOR, PS1