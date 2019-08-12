# Only works for Rice modules
function RiceModule {
    param ([switch]$Load, [switch]$Unload, [switch]$List, [string]$mod)
    
    if ($List) {
        Write-Output "Available Rice modules:`n======================="
        Get-ChildItem $PSScriptRoot | Where-Object {$_.Name.EndsWith('.psm1')} | ForEach-Object {$_.BaseName}
        return
    }
    # Use relative path to load
    if ($Load) {
        $path = Join-Path $PSScriptRoot "$mod.psm1"
        if (Test-Path $path) {
            Import-Module -Global $path
            return
        }
        else {
            Write-Output "No such module found: $path"
            return
        }
    }
    # Give module name to unload
    if ($Unload) {
        try {
            $loaded = Get-Module -Name $mod -ErrorAction Stop
            if ($loaded.Path.StartsWith($PSScriptRoot)) {
                Remove-Module $loaded.Name
                return
            }
            else {
                Write-Output "$mod is not a Rice Module. Use <Remove-Module> to remove."
                return
            }
        }
        catch {
            Write-Output "Could not unload module $mod"
            return
        }
    }
}

Export-ModuleMember -Function *