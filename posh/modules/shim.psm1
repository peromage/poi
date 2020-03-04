$Conf = @{
    SRC = "$PSScriptRoot\..\src\shim.cs"
    BIN = "$HOME\.local\bin"
    PATT_PATH = '\{\{PathToExe\}\}'
    PATT_ARGS = '\{\{ExeExecutionArgs\}\}'
    PATT_WAIT = '\{\{WaitForExit\}\}'
    PATT_DEFINE = '#undef(?=\s+HARDCODED)'
}

function createshim {
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
        $name = [System.IO.Path]::GetFileNameWithoutExtension($path)
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
    Write-Output "Generated: $bin\$name.exe -> $path"
    # Put shim config in a .shim file if not hardcoded
    if (-not $hardcode) {
        Set-Content -Path "$bin\$name.shim" -Value `
            @(
                "path=$path"
                "args=$arguments"
                "wait=$($wait.ToString())"
            )
        Write-Output "Generated: $bin\$name.shim"
    }
}

function linktopath {
    [CmdletBinding(PositionalBinding=$false)]
    param([Parameter(Position=0)]$target,
          $name=(Get-Item $target).Name,
          $bin=$Conf.BIN)
    New-Item -ItemType SymbolicLink `
             -Target $target `
             -Path $binpath `
             -Name $name `
             -Force
}

Export-ModuleMember -Function createshim, linktopath
