<###############################################################################

.SYNOPSIS
CLI navigation commands

Created by peromage 2021/02/26
Last modified 2021/02/26

###############################################################################>

<#------------------------------------------------------------------------------
Functions
------------------------------------------------------------------------------#>
<#
.Description
This function requires lf in the path
#>
function lfChangeDirectory {
    $tmp = [IO.Path]::GetTempFileName()
    lf "-last-dir-path=$tmp"
    if (Test-Path -PathType Leaf $tmp) {
        $dst = Get-Content $tmp
        Remove-Item $tmp
        if ((Test-Path -PathType Container $dst) -and ($dst -ne $pwd.Path)) {
            Set-Location $dst
        }
    }
}

<#------------------------------------------------------------------------------
Aliases
------------------------------------------------------------------------------#>
Set-Alias lfcd lfChangeDirectory
