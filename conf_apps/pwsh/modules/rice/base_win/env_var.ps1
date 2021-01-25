<#
.SYNOPSIS
User global environment variable realted commands. Modifications will be persistent.
Modified by peromage on 2021/01/24
#>

function Set-UserEnvVars {
    param ([hashtable]$envVarHash)
    foreach ($_ in $envVarHash.GetEnumerator()) {
        [System.Environment]::SetEnvironmentVariable(
            $_.Key, $_.Value, [System.EnvironmentVariableTarget]::User)
    }
}

function Remove-UserEnvVars {
    param ([hashtable]$envVarHash)
    foreach ($_ in $envVarHash.GetEnumerator()) {
        [System.Environment]::SetEnvironmentVariable(
            $_.Key, $null, [System.EnvironmentVariableTarget]::User)
    }
}
