Set-StrictMode -Off

### Loading core modules
if (Test-Path "$PSScriptRoot\core.psm1") {Import-Module -Global "$PSScriptRoot\core.psm1"}
### Loading optional modules
# RiceModule -Load test_utils
RiceModule -Load commands
RiceModule -Load stylers
# RiceModule -Load path_helpers
# RiceModule -Load constants
# RiceModule -Load shim
### End loading modules

### Set environment (current shell)

### End set environment

### Init style
# Backup old prompt
RicePrompt -Save
# Backup old theme
if ((-not (Test-Path "$PSScriptRoot\.save\saved_pscolor.json")) -or `
    (-not (Test-Path "$PSScriptRoot\.save\saved_scheme.ini"))) {
    RiceTheme -Save
}
RicePrompt cmder
RiceTheme dracula-alt
### End init style