Set-StrictMode -Off

function RiceThePrompt {
    RiceModule -Load stylers
    # Backup old prompt
    RicePrompt -Save
    # Backup old theme
    if ((-not (Test-Path "$PSScriptRoot\.save\saved_pscolor.json")) -or `
        (-not (Test-Path "$PSScriptRoot\.save\saved_scheme.ini"))) {
        RiceTheme -Save
    }
    RicePrompt cmder
    RiceTheme dracula-alt
}

### Loading core modules
if (Test-Path "$PSScriptRoot\modules\core.psm1") {Import-Module -Global "$PSScriptRoot\modules\core.psm1"}
### Loading optional modules
RiceModule -Load commands
# RiceModule -Load stylers
# RiceModule -Load path_helpers
# RiceModule -Load constants
# RiceModule -Load shim
### End loading modules

### Set environment (current shell)

### End set environment

### Handle arguments
### Enable stylish command
# The first argument specify on and off. 0:off, other:on.
if ($args[0] -ne 0) {
    RiceThePrompt
}
