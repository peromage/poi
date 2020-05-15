# Author: Fang
# Date: 2020/02/17
param([string]$prompt_style="myposh")

# Load core module
. "$PSScriptRoot\pwshrccore.ps1"
# Loading modules
loadmodule "$PSScriptRoot\autoload" *
# Loading prompt
loadmodule "$PSScriptRoot\prompts" $prompt_style
