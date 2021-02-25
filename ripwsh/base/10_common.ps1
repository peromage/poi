<###############################################################################

.SYNOPSIS
Common utility functions

Created by peromage 2021/02/24
Last modified 2021/02/24

###############################################################################>

<#------------------------------------------------------------------------------
Functions
------------------------------------------------------------------------------#>
function listDirectory {
    [CmdletBinding(PositionalBinding=$false, DefaultParameterSetName="sortByDefault")]
    param (
        [Parameter(Position=0)][string]$path=$PWD.Path,
        [Parameter(Mandatory=$false, ParameterSetName="sortByWriteTime")][switch]$write,
        [Parameter(Mandatory=$false, ParameterSetName="sortByAccessTime")][switch]$access,
        [Parameter(Mandatory=$false, ParameterSetName="sortByCreationTime")][switch]$creation,
        [Parameter(Mandatory=$false, ParameterSetName="sortByName")][switch]$name,
        [Parameter(Mandatory=$false, ParameterSetName="sortBySize")][switch]$size
    )
    if ($write) {
        Get-ChildItem $path `
        | Sort-Object LastWriteTime `
        | Select-Object Mode,Length,LastWriteTime,Name,Target `
        | Format-Table -AutoSize
    } elseif ($access) {
        Get-ChildItem $path `
        | Sort-Object LastAccessTime `
        | Select-Object Mode,Length,LastAccessTime,Name,Target `
        | Format-Table -AutoSize
    } elseif ($creation) {
        Get-ChildItem $path `
        | Sort-Object CreationTime `
        | Select-Object Mode,Length,CreationTime,Name,Target `
        | Format-Table -AutoSize
    } elseif ($name) {
        Get-ChildItem $path `
        | Sort-Object Name `
        | Select-Object Mode,Length,LastWriteTime,Name,Target `
        | Format-Table -AutoSize
    } elseif ($size) {
        Get-ChildItem $path `
        | Sort-Object Length `
        | Select-Object Mode,Length,LastWriteTime,Name,Target `
        | Format-Table -AutoSize
    } else {
        Get-ChildItem $path `
        | Select-Object Mode,Length,LastWriteTime,Name,Target `
        | Format-Table -AutoSize
    }
}

function getHistoryPath {
    return (Get-PSReadlineOption).HistorySavePath
}

function exportVars {
    param ([hashtable]$envVarHash)
    foreach ($_ in $envVarHash.GetEnumerator()) {
        Set-Item "ENV:$($_.Key)" $_.Value
    }
}

function lfChangeDirectory {
    <#
    .Description
    This function requires lf in the path
    #>
    $tmp = [System.IO.Path]::GetTempFileName()
    lf "-last-dir-path=$tmp"
    if (Test-Path -PathType Leaf $tmp) {
        $dst = Get-Content $tmp
        Remove-Item $tmp
        if ((Test-Path -PathType Container $dst) -and ($dst -ne $pwd.Path)) {
            Set-Location $dst
        }
    }
}

function setupCygwin {
    cygwin-setup --no-admin --no-desktop --no-shortcuts --no-startmenu @args
}

<#------------------------------------------------------------------------------
Aliases
------------------------------------------------------------------------------#>
Set-Alias lfcd lfChangeDirectory
Set-Alias ll listDirectory
Set-Alias hispath getHistoryPath
Set-Alias cygwin-install setupCygwin
