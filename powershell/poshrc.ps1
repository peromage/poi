Set-StrictMode -Off

$ADMIN = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()`
    ).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
$PS1 = '"$ENV:USERNAME@${ENV:COMPUTERNAME}:$pwd $ "'

# load modules
if (Test-Path "$PSScriptRoot\alias.psm1") { Import-Module "$PSScriptRoot\alias.psm1"}
if (Test-Path "$PSScriptRoot\utils.psm1") { Import-Module "$PSScriptRoot\utils.psm1" }
if (Test-Path "$PSScriptRoot\themes.psm1") {
    Import-Module "$PSScriptRoot\themes.psm1"
    THEME_SELECTOR "dracula-alt"
}
if (Test-Path "$PSScriptRoot\prompts.psm1") {
    Import-Module "$PSScriptRoot\prompts.psm1"
    $Global:PS1 = PROMPT_SELECTOR "simple" $ADMIN
}

function Prompt {
    return Invoke-Expression $Global:PS1
}