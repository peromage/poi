##
# Common functions
##

function ListDirectory {
    [CmdletBinding(PositionalBinding=$false, DefaultParameterSetName="sortByDefault")]
    param(
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

function ChangeLfDirectory {
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

function GetHistorySavePath {
    return (Get-PSReadlineOption).HistorySavePath
}

# Alias
Set-Alias ll ListDirectory
Set-Alias lfcd ChangeLfDirectory
Set-Alias historypath GetHistorySavePath

# Exporting
Export-ModuleMember -Function * -Alias *
