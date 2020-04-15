function loadmodule {
    <#
    $path: Folder where the module resides
    $modlist: Module name list
    Note: modlist supports glob
    #>
    param([string]$path, [array]$modlist, [string]$extension=".psm1")
    foreach ($i in $modlist) {
        $mp = "$path\$i$extension"
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
