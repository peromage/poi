<###############################################################################

.SYNOPSIS
Shim generator used to delegate executable or scripts.

Created by peromage 2021/02/24
Last modified 2021/02/24

###############################################################################>

param([Parameter(Mandatory=$true)]
      [string]$target,
      [Parameter(Mandatory=$true)]
      [string]$destination,
      [string]$arguments="",
      [ValidateSet("cmd", "ps1", "lnk", "symlink", "exe")]
      [string]$type="cmd",
      [switch]$gui)

$obj = [ShimCreator]::new($target, $arguments, $gui.IsPresent)

try {
    switch ($type) {
        "cmd" {
            $dest = $obj.createCmd($destination)
        }
        "ps1" {
            $dest = $obj.createPs1($destination)
        }
        "lnk" {
            $dest = $obj.createLnk($destination)
        }
        "symlink" {
            $dest = $obj.createSymlink($destination)
        }
        "exe" {
            $dest = $obj.createExe($destination)
        }
        default {
            throw "Invalid Type"
        }
    }
    Write-Output "Shim: $dest -> $($obj.target)"
} catch {
    Write-Error "Failed to create the new shim"
    Write-Error "Failure reason:"
    Write-Error "$_"
}

<#------------------------------------------------------------------------------
Shim Implementation
------------------------------------------------------------------------------#>
class ShimCreator {
    ShimCreator([string]$target, [string]$arguments, [bool]$gui) {
        # Target path can be absolute. If it is given in relative form, current
        # working directory is used as the base path.
        $target_full = [System.IO.Path]::GetFullPath($target, $pwd)
        if (-not [System.IO.File]::Exists($target_full)) {
            throw "Target doesn't exist or it is a directory"
        }
        $this.target = $target_full
        $this.arguments = $arguments
        $this.gui = $gui
    }

    [string]resolveDestination([string]$destination, [string]$extension) {
        # Destination path can be absolute. If it is given in relative form, current
        # working directory is used as the base path.
        $dest_full = [System.IO.Path]::GetFullPath($destination, $pwd)
        # If the given destination is an existing directory, put the shim under
        # this directory. Shim name is the target's basename.
        if ([System.IO.Directory]::Exists($dest_full)) {
            $dest_full = [System.IO.Path]::Join(
                    $dest_full,
                    [System.IO.Path]::GetFileName($this.target)
            )
        }
        # If the given destination is a new file, use the name of destination
        # specified.
        else {
            # Create directory if it doesn't exist
            [System.IO.Directory]::CreateDirectory([System.IO.Path]::GetDirectoryName($dest_full))
        }
        # Change destination extension if it's given
        if (-not [string]::IsNullOrWhiteSpace($extension)) {
            $dest_full = [System.IO.Path]::ChangeExtension($dest_full, $extension)
        }
        return $dest_full
    }

    [string]createLnk([string]$destination) {
        $dest_full = $this.resolveDestination($destination, ".lnk")
        $wshell = New-Object -ComObject WScript.shell
        $shortcut = $wshell.CreateShortcut($dest_full)
        $shortcut.TargetPath = $this.target
        $shortcut.Arguments = $this.arguments
        $shortcut.Save()
        return $dest_full
    }

    [string]createCmd([string]$destination) {
        $dest_full = $this.resolveDestination($destination, ".cmd")
        if ($this.gui) {
            $expr =
@"
@echo off
start "" "$($this.target)" $($this.arguments) %*
"@
        } else {
            $expr =
@"
@echo off
"$($this.target)" $($this.arguments) %*
"@
        }
        Set-Content -Value $expr -Path $dest_full
        return $dest_full
    }

    [string]createPs1([string]$destination) {
        $dest_full = $this.resolveDestination($destination, ".ps1")
        if ($this.gui) {
            $expr =
@"
start "$($this.target)" $($this.arguments) @args
"@
        } else {
            $expr =
@"
& "$($this.target)" $($this.arguments) @args
"@
        }
        Set-Content -Value $expr -Path $dest_full
        return $dest_full
    }

    [string]createSymlink([string]$destination) {
        $dest_full = $this.resolveDestination($destination, [string]::Empty)
        New-Item -ItemType SymbolicLink `
                 -Target $this.target `
                 -Path $dest_full `
                 -Force
        return $dest_full
    }

    [string]createExe([string]$destination) {
        $dest_full = $this.resolveDestination($destination, ".exe")
        $SRC_PATH = "$PSScriptRoot/../src/shim.cs"
        $SRC_PATT_PATH = '\{\{PathToExe\}\}'
        $SRC_PATT_ARGS = '\{\{ExeArgs\}\}'
        $SRC_PATT_GUI = '\{\{IsGuiApp\}\}'
        $SRC_PATT_HARDCODE = '//#define(?=\sHARDCODE)'

        $src = Get-Content -Raw $SRC_PATH
        # Hard code the target into the exe
        $src = $src -replace $SRC_PATT_PATH, $this.target
        $src = $src -replace $SRC_PATT_ARGS, $this.arguments
        $src = $src -replace $SRC_PATT_GUI, $this.gui.ToString()
        $src = $src -replace $SRC_PATT_HARDCODE, "#define"
        # Compile exe
        Add-Type -OutputType ConsoleApplication -TypeDefinition $src -OutputAssembly $dest_full
        return $dest_full
    }

    [string]$target
    [string]$arguments
    [bool]$gui
}
