Import-Module (Join-Path $PSScriptRoot "defaults.psm1") `
    -Variable DEFAULT_BIN_PATH, DEFAULT_SHIM_PATH, PACKAGES_DIR, SHIM_SRC_PATH
Import-Module (Join-Path $PSScriptRoot "file_utils.psm1") `
    -Function FilterFilesWithoutExtension, CopyFile, WriteFile
Import-Module (Join-Path $PSScriptRoot "json_utils.psm1") `
    -Function ConvertJsonFileToHash

function GetPathFromPrompt {
    param($prompt, $default)
    $output = $default
    $input = Read-Host "$prompt ($output)"
    if ($input -ne "") {$output = $input}
    return $output
}

function RiceShim {
    param ([switch]$List, [switch]$Install, [switch]$All)

    if ($List) {
        FilterFilesWithoutExtension $PACKAGES_DIR ".json"
        return
    }

    if ($Install) {
        $bpath = GetPathFromPrompt "Specify binary path" $DEFAULT_BIN_PATH
        $spath = GetPathFromPrompt "Specify shim path" $DEFAULT_SHIM_PATH
        $pacs = ""
        if ($All) {
            $pacs = FilterFilesWithoutExtension $PACKAGES_DIR ".json"
        }
        else {
            $pacs = $args
        }
        if ($pacs.Count -ne 0) {
            # compile shim
            $shimexe = "$ENV:TEMP\shim.exe"
            Add-Type -OutputAssembly $shimexe -OutputType ConsoleApplication `
                (Get-Content -Raw $SHIM_SRC_PATH)
            foreach ($i in $pacs) {
                $pac = Join-Path $PACKAGES_DIR "$i.json"
                if (Test-Path $pac) {
                    $conf = ConvertJsonFileToHash $pac
                    $dir = Join-Path $bpath $conf.dir
                    foreach ($b in $conf.bin) {
                        $execpath = ""
                        $execargs = ""
                        $exec = Join-Path $dir $b.exec
                        $exec = '"'+$exec+'"'
                        # script file
                        if ($b.interpreter.Length -ne 0) {
                            $execpath = $b.interpreter
                            $execargs = $b.args.Replace('$path', $exec)
                        }
                        # executable
                        else {
                            $execpath = $exec
                            $execargs = $b.args
                        }
                        $target = Join-Path $spath $b.name
                        CopyFile $shimexe "$target.exe"
                        WriteFile "$target.shim" "path=$execpath`nargs=$execargs"
                    }
                }
                else {
                    Write-Output "No package file found: $pac"
                }
            }
            Remove-Item $shimexe
        }
        else {

        }
        return
    }
}

Export-ModuleMember -Function RiceShim