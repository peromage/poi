<#
.SYNOPSIS
Rice config core initialization file.
Modified by peromage on 2021/01/20
#>

# RC root directory
$global:RICE_ROOT = $PSScriptRoot

# Rice functions
function global:RiceModuleImport {
    <#
    .SYNOPSIS
    Load module of given path. The imported modules by this
    function will be added a prefix. Wildcard is supported.
    .PARAMETER path
    A string to the module which needs to be loaded. It can have wildcard.
    .PARAMETER addPrefix
    Enable/disable module prefix when imported.
    #>
    param ([string]$path, [string]$prefix="")
    $moduleList = @(Get-ChildItem -Path $path)
    Import-Module -Global -DisableNameChecking -Prefix $prefix -Name $moduleList

}

function global:RiceLoadModule {
    param ([string]$name)
    global:RiceModuleImport "${RICE_ROOT}/modules/${name}.psm1"
}

function global:RiceLoadTheme {
    param ([string]$name)
    global:RiceModuleImport "${RICE_ROOT}/themes/${name}.psm1"
}

function RiceConfigInit {
    <#
    .SYNOPSIS
    Rice config initialization function
    #>
    # Load modules in autoload.d directory
    RiceModuleImport "$RICE_ROOT/autoload.d/*.psm1"

    # Only proceeds following when rice configuration table presents
    if ($global:RICE_CONFIGS -isnot [hashtable]) { return }
    # Loading prompt theme
    if (($val = $global:RICE_CONFIGS["theme"]) -and ($val -is [string])) {
        RiceLoadTheme $val
    }
    # Load additional modules
    if (($val = $global:RICE_CONFIGS["modules"]) -and ($val -is [array])) {
        foreach ($_ in $val) {
            RiceLoadModule $_
        }
    }
}
