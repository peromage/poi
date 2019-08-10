Set-StrictMode -Off

### Load core modules
if (Test-Path "$PSScriptRoot\core.psm1") { Import-Module  -Global "$PSScriptRoot\core.psm1"}

### Optional modules
RiceModule -Load aliases
RiceModule -Load stylers
#RiceModule -Load env_helpers
#RiceModule -Load constants
#RiceModule -Load utils
#RiceModule -Load shim

### Set environment (current shell)
if ($Env:PSModulePath.EndsWith(";")) {
    $Env:PSModulePath += $PSScriptRoot
}
else {
    $Env:PSModulePath += ";" + $PSScriptRoot
}

ChangePrompt cmder
ChangeTheme dracula-alt