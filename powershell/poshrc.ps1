Set-StrictMode -Off

### Load modules
if (Test-Path "$PSScriptRoot\core.psm1") { Import-Module "$PSScriptRoot\core.psm1"}
if (Test-Path "$PSScriptRoot\aliases.psm1") { Import-Module "$PSScriptRoot\aliases.psm1"}
if (Test-Path "$PSScriptRoot\stylers.psm1") { Import-Module "$PSScriptRoot\stylers.psm1"}

### Optional modules
#if (Test-Path "$PSScriptRoot\env_helper.psm1") { Import-Module "$PSScriptRoot\env_helpers.psm1"}
#if (Test-Path "$PSScriptRoot\constants.psm1") { Import-Module "$PSScriptRoot\constants.psm1" }
#if (Test-Path "$PSScriptRoot\utils.psm1") { Import-Module "$PSScriptRoot\utils.psm1" }
#if (Test-Path "$PSScriptRoot\shim.psm1") { Import-Module "$PSScriptRoot\shim.psm1" }

### Set environment (current shell)
if ($Env:PSModulePath.EndsWith(";")) {
    $Env:PSModulePath += $PSScriptRoot
}
else {
    $Env:PSModulePath += ";" + $PSScriptRoot
}

ChangePrompt cmder
ChangeTheme dracula-alt