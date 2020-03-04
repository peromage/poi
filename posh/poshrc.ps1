# Author: Fang
# Date: 2020/02/17

# Don't add code before the initialization
#region Initialization DO NOT TOUCH
# Module loader: Search and load module in a directory
function loadmodule {
    # $p: Folder where the module resides
    # $m: Module names. Separated by ','
    param($p, $m)
    $modules = $m.Split(",")|ForEach-Object {$_.Trim()}
    foreach ($i in $modules) {
        $temp = "$p\$i.psm1"
        if (Test-Path $temp) {
            Import-Module $temp
        } else {
            Write-Output "Module not found: $temp"
        }
    }
}
#endregion

#region My code
# Loading modules
loadmodule "$PSScriptRoot\modules" "commands,path,shim"
# Loading prompt
loadmodule "$PSScriptRoot\prompts" "myposh"

# Clean up

#endregion
