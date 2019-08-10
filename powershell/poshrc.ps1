Set-StrictMode -Off

### Load core modules
if (Test-Path "$PSScriptRoot\core.psm1") { Import-Module  -Global "$PSScriptRoot\core.psm1"}

### Optional modules
RiceModule -Load -Global aliases
RiceModule -Load -Global stylers
#RiceModule -Load -Global path_helpers
#RiceModule -Load -Global constants
#RiceModule -Load -Global utils
#RiceModule -Load -Global shim

### Set environment (current shell)

### Set default style
ChangePrompt cmder
ChangeTheme dracula-alt