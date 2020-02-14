Set-StrictMode -Off

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
## Usage poshrc.ps1 [theme] [prompt]
if ($args.Count -gt 0) {
    RiceModule -Load stylers
    # Backup old prompt
    RicePrompt -Save
    # Backup old theme
    if ((-not (Test-Path "$PSScriptRoot\.save\saved_pscolor.json")) -or `
        (-not (Test-Path "$PSScriptRoot\.save\saved_scheme.ini"))) {
        RiceTheme -Save
    }
    if ($null -ne $args[0]) {
        RiceTheme $args[0]
    }
    if ($null -ne $args[1]) {
        RicePrompt $args[1]
    }
}
