#######################################
## Created by peromage on 2020/02/17 ##
#######################################

# User configurations
#
# Themes in __rc__/themes directory. This value should be a string.
#$RC_THEME = "style_std"

# Modules in __rc__/modules directory. This value should be an array.
#$RC_Modules = @("nt_admin")

# Uncomment this to enable force reload
#$RC_HAS_INIT = $false

#region Do Not Touch
# Shortcut to edit the init file
$INIT_FILE = $MyInvocation.MyCommand.Source
function RcInitFile {
    if (Test-Path ENV:EDITOR) {
        Invoke-Expression  "$ENV:EDITOR $INIT_FILE"
    } else {
        Write-Host "No ENV:EDITOR found!"
    }
}
# Load rc.ps1
. "${PSScriptRoot}/__rc__/rc.ps1"
#endregion
