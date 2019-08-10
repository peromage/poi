Set-StrictMode -Off

### Loading core modules
if (Test-Path "$PSScriptRoot\core.psm1") {Import-Module -Global "$PSScriptRoot\core.psm1"}
### Loading optional modules
# Suppress output
Invoke-Command -ScriptBlock {
RiceModule -Load aliases
RiceModule -Load stylers
#RiceModule -Load path_helpers
#RiceModule -Load constants
#RiceModule -Load utils
#RiceModule -Load shim
} | Out-Null

### Set environment (current shell)

### Init style
ChangePrompt cmder
ChangeTheme dracula-alt