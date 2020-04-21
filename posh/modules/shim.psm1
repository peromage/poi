$Conf = @{
    SRC = "$PSScriptRoot\..\src\shim.cs"
    BIN = "$HOME\.local\bin"
    PATT_PATH = '\{\{PathToExe\}\}'
    PATT_ARGS = '\{\{ExeExecutionArgs\}\}'
    PATT_WAIT = '\{\{WaitForExit\}\}'
    PATT_DEFINE = '#undef(?=\s+HARDCODED)'
}

function CreateShim {
    [CmdletBinding(PositionalBinding=$false)]
    param([Parameter(Position=0)][string]$path,
          [string]$name="",
          [string]$arguments="",
          [string]$source=$Conf.SRC,
          [string]$bin=$Conf.BIN,
          [bool]$wait=$true,
          [bool]$hardcode=$true)
    # Validate exe path
    if (($null -eq $path) -or ("" -eq $path) -or (-not (Test-Path $path))) {
        Write-Output "Invalid path"
        return
    }
    $path = (Resolve-Path $path).Path
    # Get output shim name
    if ("" -eq $name) {
        $name = (Get-Item $path).BaseName
    }
    # Valida output bin directory
    if (-not (Test-Path $bin)) {
        New-Item -Force -ItemType Directory -Path $bin
    }
    # Get shim source code
    $src_code = Get-Content -Raw $source
    # Subtitute source code if it's hardcode mode
    if ($hardcode) {
        $src_code = $src_code -replace $Conf.PATT_PATH, $path
        $src_code = $src_code -replace $Conf.PATT_ARGS, $arguments
        $src_code = $src_code -replace $Conf.PATT_WAIT, $wait.ToString()
        $src_code = $src_code -replace $Conf.PATT_DEFINE, "#define"
    }
    # Compile to shim
    Add-Type -OutputAssembly "$bin\$name.exe" -OutputType ConsoleApplication -TypeDefinition $src_code
    Write-Output "Created: $bin\$name.exe -> $path"
    # Put shim config in a .shim file if not hardcoded
    if (-not $hardcode) {
        Set-Content -Path "$bin\$name.shim" -Value `
            @(
                "path=$path"
                "args=$arguments"
                "wait=$($wait.ToString())"
            )
        Write-Output "Created: $bin\$name.shim"
    }
}

function LinkShim {
    [CmdletBinding(PositionalBinding=$false)]
    param([Parameter(Position=0)][string]$target,
          [string]$name=(Get-Item $target).Name,
          [string]$bin=$Conf.BIN)
    # Append .exe suffix if name doesn't contain .exe extension
    $patt = "\.exe$"
    if (($target -match $patt) -and (-not ($name -match $patt))) {
        $name = "$name.exe"
    }
    $link = New-Item -ItemType SymbolicLink -Target $target -Path $bin -Name $name -Force
    Write-Output "Linked: $($link.FullName) -> $($link.Target)"
}

function ShortcutShim {
    [CmdletBinding(PositionalBinding=$false)]
    param([Parameter(Position=0)][string]$target,
          [string]$name="",
          [string]$arguments="",
          [string]$bin=$Conf.BIN,
          [ValidateSet("cmd", "bat", "ps1", "lnk", "auto")][string]$type="auto")
    # Get destination name
    $otar = Get-Item $target
    if ($name -eq "") {
        $name = $otar.BaseName
    }
    # Functions to generate shortcuts. Return a string of generated file path.
    function genlnk {
        $wshell = New-Object -ComObject WScript.shell
        $dst = "$bin\$name.lnk"
        $shortcut = $wshell.CreateShortcut($dst)
        $shortcut.TargetPath = $otar.FullName
        $shortcut.Arguments = $arguments
        $shortcut.Save()
        return $dst
    }
    function gencmd {
        $dst = "$bin\$name.cmd"
        @("@echo off","$($otar.FullName) $arguments %*") `
        | Set-Content -Path $dst
        return $dst
    }
    function genbat {
        $dst = "$bin\$name.bat"
        @("@echo off", "$($otar.FullName) $arguments %*") `
        | Set-Content -Path $dst
        return $dst
    }
    function genps1_invoke {
        $dst = "$bin\$name.ps1"
        "Invoke-Expression `"$($otar.FullName) $arguments `$args`"" `
        | Set-Content -Path $dst
        return $dst
    }
    function genps1_source {
        $dst = "$bin\$name.ps1"
        ". `"$($otar.FullName)`" $arguments @args" `
        | Set-Content -Path $dst
        return $dst
    }
    function genauto {
        switch ($otar.Extension.ToLower()) {
            ".cmd" {
                return gencmd
            } ".bat" {
                return genbat
            } ".ps1" {
                # Instead of execute ps1 script directly, auto mode sources it
                # (execute in the same context)
                return genps1_source
            } default {
                return genlnk
            }
        }
    }
    # Default shortcut type
    Write-Verbose "Generated shortcut type is $type"
    switch ($type) {
        "lnk" {
            $dest = genlnk
            break
        } "cmd" {
            $dest = gencmd
            break
        } "bat" {
            $dest = genbat
            break
        } "ps1" {
            $dest = genps1_invoke
            break
        } default {
            $dest = genauto
            break
        }
    }
    Write-Output "Shortcut: $($otar.FullName) -> $dest"
}

function CreateShimFromManifest {
    param([string]$json_file)
    function is_valid($v, $t) {
        if ($null -eq $v) {
            return $false
        }
        if ($v.GetType().FullName -eq $t) {
            if ($t -eq "System.String") {
                return (-not [System.String]::IsNullOrWhiteSpace($v))
            }
            return $true
        }
        return $false
    }
    # Read json file
    $j = Get-Content -Raw $json_file | ConvertFrom-Json
    # Iterate apps key
    foreach ($app in $j.apps) {
        # Check parameters
        # $d dictionary contains arguments for createshim
        $d = @{}
        $str_t = "System.String"
        $bool_t = "System.Boolean"
        # "path" is mandantory
        if (-not (is_valid $app.path $str_t)) {
            continue
        }
        $d["path"] = $app.path
        if (is_valid $app.args $str_t) {
            $d["arguments"] = $app.args
        }
        if (is_valid $app.wait $bool_t) {
            $d["wait"] = $app.wait
        }
        if (is_valid $app.hardcode $bool_t) {
            $d["hardcode"] = $app.hardcode
        }
        if (is_valid $app.name $str_t) {
            $d["name"] = $app.name
        }
        if (is_valid $app.bin $str_t) {
            $d["bin"] = $app.bin
        }
        CreateShim @d
    }
}

function GenerateManifest {
    param([string]$root=$pwd.Path, [int]$depth=1)
    function new_entry {
        return [ordered]@{
            path = ""
            args = ""
            name = ""
            bin = ""
            wait = $true
            hardcode = $true
        }
    }
    # Validate path
    if (-not (Test-Path $root)) {
        Write-Output "Invalid path"
        return
    }
    # Resolve absolute path
    $root = (Resolve-Path $root).Path
    # Walk through root directory and sub directories to get executables
    $exe_list = Get-ChildItem -Path $root -Name *.exe -Depth $depth
    # create entries for each executable
    $json = @{ apps = [System.Collections.ArrayList]@() }
    foreach ($exe in $exe_list) {
        $d = new_entry
        $d.path = (Join-Path $root $exe)
        Write-Verbose "Find $($d.path)"
        $json.apps.Add($d) | Out-Null
    }
    $json_file = Join-Path $root "manifest.json"
    $json | ConvertTo-Json | Set-Content $json_file
    Write-Output "Created $json_file"
}
