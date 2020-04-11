# Author: Fang
# Date: 2020/02/17

# Don't add code before the initialization
#region Initialization DO NOT TOUCH
# Module loader: Search and load module in a directory
function loadmodule {
    <#
    $path: Folder where the module resides
    $modlist: Module name list
    Note: modlist supports glob
    #>
    param([string]$path, [array]$modlist)
    foreach ($i in $modlist) {
        $mp = "$path\$i.psm1"
        $ml = Get-Item -Path $mp
        if ($null -eq $ml) {
            Write-Output "Module not found: $mp"
            continue
        }
        foreach ($m in $ml) {
            Import-Module -DisableNameChecking $m.FullName
        }
    }
}
#endregion

#region My code
# Loading modules
loadmodule "$PSScriptRoot\modules" commands,path,shim
# Loading prompt
loadmodule "$PSScriptRoot\prompts" myposh

# Clean up

#endregion
