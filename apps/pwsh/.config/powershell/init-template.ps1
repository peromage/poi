# Quick edit configuration file
$init_file = $MyInvocation.MyCommand.Source
function RcConfig { notepad  $init_file }

# Load core file
. "$PSScriptRoot\pwshrc.ps1"
