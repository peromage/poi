# Quick edit configuration file
$init_file = $MyInvocation.MyCommand.Source
function RcConfig { iex  "$ENV:EDITOR $init_file" }

# Load core file
. "$PSScriptRoot\pwshrc.ps1"
