Import-Module (Join-Path $PSScriptRoot "defaults.psm1") `
    -Variable DEFAULT_LIB_PATH, DEFAULT_BIN_PATH, PACKAGES_DIR, SHIM_SRC_PATH
Import-Module (Join-Path $PSScriptRoot "file_helpers.psm1") `
    -Function Show-FilesWithoutExtension, Copy-File, Write-File
Import-Module (Join-Path $PSScriptRoot "json_helpers.psm1") `
    -Function Convert-JsonFileToHash
Import-Module (Join-Path $PSScriptRoot "path_helpers.psm1") `
    -Function Add-EnvUserPath, Remove-EnvUserPath

function GetPathFromPrompt {
    param($prompt, $default)
    $output = $default
    $input = Read-Host "$prompt ($output)"
    if ($input -ne "") {$output = $input}
    return $output
}

function RiceShim {
    [CmdletBinding(PositionalBinding=$false)]
    param ([switch]$List, [switch]$Install, [switch]$All,
           [string]$Lib = "", [string]$Bin = "",
           [string[]][Parameter(ValueFromRemainingArguments)]$packages
           )

    if ($List) {
        Show-FilesWithoutExtension $PACKAGES_DIR ".json"
        return
    }

    if ($Install) {
        $success = $false
        $lpath = if ("" -eq $Lib) {GetPathFromPrompt "Specify lib path" $DEFAULT_LIB_PATH} else {$Lib}
        $bpath = if ("" -eq $Bin) {GetPathFromPrompt "Specify bin path" $DEFAULT_BIN_PATH} else {$Bin}
        $pacs = if ($All) {Show-FilesWithoutExtension $PACKAGES_DIR ".json"} else {$packages}

        if ($pacs.Count -ne 0) {
            # Compile shim
            $shimexe = "$ENV:TEMP\shim.exe"
            Add-Type -OutputAssembly $shimexe -OutputType ConsoleApplication `
                (Get-Content -Raw $SHIM_SRC_PATH)
            # Add bin directory to user path
            Add-EnvUserPath $bpath
            # Walk through each package config
            foreach ($i in $pacs) {
                $pac = Join-Path $PACKAGES_DIR "$i.json"
                if (Test-Path $pac) {
                    $conf = Convert-JsonFileToHash $pac
                    # App directory
                    $dir = Join-Path $lpath $conf.dir
                    # Install shim for each bin
                    foreach ($b in $conf.bin) {
                        $execpath = ""
                        $execargs = ""
                        $exec = Join-Path $dir $b.exec
                        $exec = '"'+$exec+'"'
                        # script file
                        if ($b.interpreter.Length -ne 0) {
                            $execpath = $b.interpreter
                            $execargs = $b.interpreterargs.Replace('$exec', $exec)
                        }
                        # executable
                        else {
                            $execpath = $exec
                            $execargs = $b.interpreterargs
                        }
                        $target = Join-Path $bpath $b.name
                        Copy-File $shimexe "$target.exe"
                        Write-File "$target.shim" "path=$execpath`nargs=$execargs"
                    }
                    # Apply env settings
                    if ($null -ne $conf.env) {
                        foreach ($e in $conf.env) {Add-EnvUserPath $e}
                    }
                    # Apply post installation script
                    if ($null -ne $conf.post) {
                        foreach ($p in $conf.post) {Invoke-Expression $p}
                    }
                    $success = $true
                }
                else {
                    Write-Output "No package file found: $pac"
                }
            }
            # If no package installed, remove shim path env variable
            if (-not $success) {Remove-EnvUserPath $bpath}
            # Remove temp compiled shim binary
            Remove-Item $shimexe
        }
        else {
            Write-Output "Specify package name. Use <RiceShim -List> to see all available packages."
        }
        return
    }
}

Export-ModuleMember -Function RiceShim
