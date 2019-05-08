Set-StrictMode -Off

$ADMIN = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()`
    ).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
$PS1 = '"$ENV:USERNAME@${ENV:COMPUTERNAME}:$pwd $ "'

# load modules
if (Test-Path "$PSScriptRoot\utils.ps1") { . "$PSScriptRoot\utils.ps1" }
if (Test-Path "$PSScriptRoot\themes.ps1") {
    . "$PSScriptRoot\themes.ps1"
    THEME_SELECTOR "dracula-alt"
}
if (Test-Path "$PSScriptRoot\prompts.ps1") {
    . "$PSScriptRoot\prompts.ps1"
    PROMPT_SELECTOR "simple" $ADMIN
}

function Prompt {
    return Invoke-Expression $PS1
}