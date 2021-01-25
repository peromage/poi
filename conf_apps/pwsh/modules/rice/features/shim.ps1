<#
.SYNOPSIS
Shim generator used to delegate executable or scripts.
Modified by peromage on 2021/01/24
#>

function New-ShimObject {
    param ([string]$target, [string]$arguments, [bool]$gui)
    if (-not (Test-Path $target)) {
        throw "Invalid target"
    }
    $shimObj = [PSCustomObject]@{
        Target = Get-Item $target
        Arguments = $arguments
        Gui = $gui
    }
    function addMethod {
        Add-Member -InputObject $shimObj -MemberType ScriptMethod -Name $args[0] -Value $args[1]
    }

    # Member methods definitions
    addMethod "resolveDestination" {
        param ([string]$destination, [string]$extension)
        if ([string]::IsNullOrWhiteSpace($extension)) {
            $trimmedExt = [string]::Empty
        } else {
            $trimmedExt = ".$($extension.TrimStart("."))"
        }
        $fullDest = $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath($destination)
        if (Test-Path -PathType Container $destination) {
            if ($this.Target.Name.EndsWith($trimmedExt)) {
                # Use target name and ext in the destination directory
                $fullDest = Join-Path $fullDest $this.Target.Name
            } else {
                # Use target name and provided ext in the destination directory
                $fullDest = Join-Path $fullDest "$($this.Target.BaseName)${trimmedExt}"
            }
        } else {
            # Otherwise use the given name
            if (-not $fullDest.EndsWith($trimmedExt)) {
                $fullDest = "${fullDest}${trimmedExt}"
            }
        }
        return $fullDest
    }

    addMethod "genLnk" {
        param ([string]$destination)
        $fullDestination = $this.resolveDestination($destination, ".lnk")
        $wshell = New-Object -ComObject WScript.shell
        $shortcut = $wshell.CreateShortcut($fullDestination)
        $shortcut.TargetPath = $this.Target.FullName
        $shortcut.Arguments = $this.Arguments
        $shortcut.Save()
        return $fullDestination
    }

    addMethod "genCmd" {
        param ([string]$destination)
        $fullDestination = $this.resolveDestination($destination, ".cmd")
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
        Set-Content -Value $expr -Path $fullDestination
        return $fullDestination
    }

    addMethod "genPs1" {
        param ([string]$destination)
        $fullDestination = $this.resolveDestination($destination, ".ps1")
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
        Set-Content -Value $expr -Path $fullDestination
        return $fullDestination
    }

    addMethod "genSymlink" {
        param ([string]$destination)
        $fullDestination = $this.resolveDestination($destination, $this.Target.Extension)
        New-Item -ItemType SymbolicLink `
                 -Target $this.Target.FullName `
                 -Path $fullDestination `
                 -Force
        return $fullDestination
    }

    addMethod "genExe" {
        param ([string]$destination)
        $fullDestination = $this.resolveDestination($destination, ".exe")
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
        Add-Type -OutputType ConsoleApplication -TypeDefinition $src -OutputAssembly $fullDestination
        return $fullDestination
    }

    return $shimObj
}

function New-Shim {
    param([Parameter(Mandatory=$true)]
          [string]$target,
          [Parameter(Mandatory=$true)]
          [string]$destination,
          [string]$arguments="",
          [ValidateSet("cmd", "ps1", "lnk", "symlink", "exe")]
          [string]$type="cmd",
          [switch]$gui)
    $obj = New-ShimObject $target $arguments $gui.IsPresent
    try {
        switch ($type) {
            "cmd" {
                $dest = $obj.genCmd($destination)
            }
            "ps1" {
                $dest = $obj.genPs1($destination)
            }
            "lnk" {
                $dest = $obj.genLnk($destination)
            }
            "symlink" {
                $dest = $obj.genSymlink($destination)
            }
            "exe" {
                $dest = $obj.genExe($destination)
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
