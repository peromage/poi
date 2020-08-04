class Shimctl {
    [System.IO.FileInfo]$Target
    [string]$Arguments
    [string]$Name
    [bool]$Gui

    Shimctl([string]$target, [string]$arguments) {
        $this.Reset($target, $arguments)
    }

    [void]Reset([string]$target, [string]$arguments) {
        if (-not (Test-Path $target)) {
            throw "Invalid target"
        }
        $this.Target = Get-Item $target
        $this.Arguments = $arguments
        $this.Name = $this.Target.BaseName
        $this.Gui = $false
    }

    hidden [string]BuildDest([string]$dir, [string]$ext) {
        return Join-Path (Resolve-Path $dir).Path "$($this.Name).$($ext.TrimStart("."))"
    }

    [string]GenLnk([string]$dir) {
        $dest = $this.BuildDest($dir, ".lnk")
        $wshell = New-Object -ComObject WScript.shell
        $shortcut = $wshell.CreateShortcut($dest)
        $shortcut.TargetPath = $this.Target.FullName
        $shortcut.Arguments = $this.Arguments
        $shortcut.Save()
        return $dest
    }

    [string]GenCmd([string]$dir) {
        $dest = $this.BuildDest($dir, ".cmd")
        if ($this.Gui) {
            $expr = @(
                "@echo off"
                "start `"`" `"$($this.Target.FullName)`" $($this.Arguments) %*"
            )
        } else {
            $expr = @(
                "@echo off"
                "`"$($this.Target.FullName)`" $($this.Arguments) %*"
            )
        }
        Set-Content -Value $expr -Path $dest
        return $dest
    }

    [string]GenPs1([string]$dir) {
        $dest = $this.BuildDest($dir, ".ps1")
        if ($this.Target.Extension.ToLower() -eq ".ps1") {
            $expr = @(
                # Execute ps1 script in current session
                ". `"$($this.Target.FullName)`" $($this.Arguments) @args"
            )
        } elseif ($this.Gui) {
            $expr = @(
                "start `"$($this.Target.FullName)`" $($this.Arguments) @args"
            )
        } else {
            $expr = @(
                "& `"$($this.Target.FullName)`" $($this.Arguments) @args"
            )
        }
        Set-Content -Value $expr -Path $dest
        return $dest
    }

    [string]GenSoftlink([string]$dir) {
        $dest = $this.BuildDest($dir, $this.Target.Extension)
        New-Item -ItemType SymbolicLink `
                 -Target $this.Target.FullName `
                 -Path $dest `
                 -Force
        return $dest
    }

    [string]GenExe([string]$dir) {
        $dest = $this.BuildDest($dir, ".exe")
        $SRC_PATH = "$PSScriptRoot/../src/shim.cs"
        $SRC_PATT_PATH = '\{\{PathToExe\}\}'
        $SRC_PATT_ARGS = '\{\{ExeArgs\}\}'
        $SRC_PATT_GUI = '\{\{IsGuiApp\}\}'
        $SRC_PATT_HARDCODE = '//#define(?=\sHARDCODE)'

        $src = Get-Content -Raw $SRC_PATH
        # Hard code the target into the exe
        $src = $src -replace $SRC_PATT_PATH, $this.Target.FullName
        $src = $src -replace $SRC_PATT_ARGS, $this.Arguments
        $src = $src -replace $SRC_PATT_GUI, $this.Gui.ToString()
        $src = $src -replace $SRC_PATT_HARDCODE, "#define"
        # Compile exe
        Add-Type -OutputType ConsoleApplication -TypeDefinition $src -OutputAssembly $dest
        return $dest
    }
}

function New-Shim {
    param([Parameter(Mandatory=$true)]
          [string]$target,
          [string]$name="",
          [string]$arguments="",
          [ValidateSet("cmd", "ps1", "lnk", "softlink", "exe")]
          [string]$type="exe",
          [string]$bin="$HOME/.local/bin",
          [switch]$gui)
    $obj = [Shimctl]::new($target, $arguments)
    # Check for options
    if ($name -ne "") {
        $obj.Name = $name
    }
    if ($gui) {
        $obj.Gui = $true
    } else {
        $obj.Gui = $false
    }
    try {
        switch ($type) {
            "cmd" {
                $dest = $obj.GenCmd($bin)
            }
            "ps1" {
                $dest = $obj.GenPs1($bin)
            }
            "lnk" {
                $dest = $obj.GenLnk($bin)
            }
            "softlink" {
                $dest = $obj.GenSoftlink($bin)
            }
            "exe" {
                $dest = $obj.GenExe($bin)
            }
            default {
                throw "Invalid Type"
            }
        }
        Write-Output "Shim: $dest -> $($obj.Target.FullName)"
    } catch {
        Write-Error "Failed to create the new shim"
        Write-Error "Failure reason:"
        Write-Error "$_"
    }
}
