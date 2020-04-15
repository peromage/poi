# Author: Fang
# Date: 2020/02/17

# Load core module
Import-Module -DisableNameChecking "$PSScriptRoot\rcore.psm1"
# Loading modules
loadmodule "$PSScriptRoot\modules" commands,path,shim
# Loading prompt
loadmodule "$PSScriptRoot\prompts" myposh
