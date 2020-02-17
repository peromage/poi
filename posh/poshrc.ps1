# Initialize variables
$_loaded_modules = @("commands", "path")
$_loaded_prompt = "myposh"

#region DO NOT TOUCH BELOW
$_loaded = $null
# Loading modules
foreach ($i in $_loaded_modules) {
    $_loaded = "$PSScriptRoot\modules\$i.psm1"
    if (Test-Path $_loaded) {
        Import-Module $_loaded
    } else {
        Write-Output "Module not found: $_loaded"
    }
}
# Loading prompt
$_loaded = "$PSScriptRoot\prompts\$_loaded_prompt.psm1"
if (Test-Path $_loaded) {
    Import-Module $_loaded
} else {
    Write-Output "Module not found: $_loaded"
}
# Clean up
Remove-Variable _loaded_modules
Remove-Variable _loaded_prompt
Remove-Variable _loaded
#endregion
