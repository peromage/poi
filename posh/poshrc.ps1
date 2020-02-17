# Initialize variables
$_loaded_modules = "commands, path"
$_loaded_prompt = "myposh"

#region DO NOT TOUCH BELOW
# Module loader: Search and load module in a directory
function loadmodule {
    param($m, $p)
    $modules = $m.Split(",")|ForEach-Object {$_.Trim()}
    foreach ($i in $modules) {
        $temp = "$PSScriptRoot\$p\$i.psm1"
        if (Test-Path $temp) {
            Import-Module $temp
        } else {
            Write-Output "Module not found: $temp"
        }
    }
}
# Loading modules
loadmodule $_loaded_modules modules
# Loading prompt
loadmodule $_loaded_prompt prompts
# Clean up
Remove-Variable _loaded_modules
Remove-Variable _loaded_prompt
#endregion
