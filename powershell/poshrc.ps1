Set-StrictMode -Off

# load modules
if (Test-Path "$PSScriptRoot\alias.psm1") { Import-Module "$PSScriptRoot\alias.psm1"}

if (Test-Path "$PSScriptRoot\utils.psm1") { Import-Module "$PSScriptRoot\utils.psm1" }

if (Test-Path "$PSScriptRoot\themes.psm1") { 
    Import-Module "$PSScriptRoot\themes.psm1"
    THEME_SELECTOR "dracula"
}

if (Test-Path "$PSScriptRoot\prompts.psm1") {
    Import-Module "$PSScriptRoot\prompts.psm1"
    PROMPT_SELECTOR "win"
}

function Prompt {
    return PS1
}