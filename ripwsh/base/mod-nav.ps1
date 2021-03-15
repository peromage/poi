<###############################################################################

.SYNOPSIS
CLI navigation commands

Created by peromage 2021/02/26
Last modified 2021/02/26

###############################################################################>

<#------------------------------------------------------------------------------
Functions
------------------------------------------------------------------------------#>
# lf
function lfcd {
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

# z.lua
function zb { z -b @args }
function zc { z -c @args }
function zi { z -i @args }
function zf { z -I @args }

<#------------------------------------------------------------------------------
Aliases
------------------------------------------------------------------------------#>
