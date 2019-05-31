# default style
$PS1 = '"$ENV:USERNAME@${ENV:COMPUTERNAME}:$pwd $ "'
$ADMIN = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()`
    ).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
$ESC = [char]0x1b

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

function _PROMPT_CMDER_ {
    if ($Script:ADMIN) {
        $Script:PS1 = '" $ESC[31m$pwd$ESC[0m`n !> "'
        $Host.ui.RawUI.WindowTitle = "Administrator:$ENV:USERNAME@$ENV:COMPUTERNAME"
    }
    else {
        $Script:PS1 = '" $ESC[32m$pwd$ESC[0m`n > "'
        $Host.ui.RawUI.WindowTitle = "$ENV:USERNAME@$ENV:COMPUTERNAME"
    }
}

function _PROMPT_SIMPLE_ {
    if ($Script:ADMIN) {
        $Script:PS1 = '"[$ESC[31m${ENV:USERNAME}$ESC[0m@${ENV:COMPUTERNAME}:$(_PWD_HOME_TILDE_DIR_)]# "'
        $Host.ui.RawUI.WindowTitle = "Administrator:$ENV:USERNAME@$ENV:COMPUTERNAME"
    }
    else {
        $Script:PS1 = '"[$ESC[32m${ENV:USERNAME}$ESC[0m@${ENV:COMPUTERNAME}:$(_PWD_HOME_TILDE_DIR_)]$ "'
        $Host.ui.RawUI.WindowTitle = "$ENV:USERNAME@$ENV:COMPUTERNAME"
    }
}

function PROMPT_SELECTOR {
    param($Style)

    switch ($Style) {
        "simple" { _PROMPT_SIMPLE_; break }
        "cmder" { _PROMPT_CMDER_; break }
    }
}

function PS1 {
    Invoke-Expression $Script:PS1
}

Export-ModuleMember -Function PROMPT_SELECTOR, PS1