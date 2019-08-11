Set-StrictMode -Off

### Loading core modules
if (Test-Path "$PSScriptRoot\core.psm1") {Import-Module -Global "$PSScriptRoot\core.psm1"}
### Loading optional modules
# Suppress output
Invoke-Command -ScriptBlock {
RiceModule -Load commands
RiceModule -Load stylers
#RiceModule -Load path_helpers
#RiceModule -Load constants
#RiceModule -Load utils
RiceModule -Load shim
} | Out-Null
### End loading optional modules

### Set environment (current shell)

### End set environment

### Init style
# Backup old prompt
ChangePrompt -Save
# Backup old theme
if ((-not (Test-Path "$PSScriptRoot\.save\saved_pscolor.json")) -or `
    (-not (Test-Path "$PSScriptRoot\.save\saved_scheme.ini"))) {
    ChangeTheme -Save
}
ChangePrompt p-cmder
ChangeTheme dracula-alt
### End init style