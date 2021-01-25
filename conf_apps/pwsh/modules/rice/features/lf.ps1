<#
.SYNOPSIS
File manager Lf helper commands.
Modified by peromage on 2021/01/24
#>

function Set-LfDirectory {
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

Set-Alias lfcd Set-LfDirectory
