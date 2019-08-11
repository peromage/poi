Import-Module (Join-Path $PSScriptRoot "defaults.psm1") `
    -Variable DEFAULT_BIN_PATH, DEFAULT_SHIM_PATH

function RiceShim {
    param ([switch]$List, [switch]$Install)

    $binPath = GetPathFromPrompt "Binaries path"
    $shimPath = GetPathFromPrompt "Shims path"

    foreach ($b in $MyBin.GetEnumerator())
    {
        $shim = Join-Path $shimPath ($b.Name + ".exe")
        $bin = Join-Path $binPath $b.Value
        if (-not (Test-Path $bin))
        {
            # set bin placeholder
            New-Item -Force -ItemType File $bin | Out-Null
        }
        # set symlink
        New-Item -ItemType SymbolicLink -Force -Path $shim -Value $bin | Out-Null
    }
    Write-Output "Done."
}