Set-StrictMode -Off
colortool dracula | Out-Null

function Prompt {
    $pt="$(Get-Location)"
    $hm="^$Env:USERPROFILE" -replace '\\','\\'
    if($pt -match $hm) {
        $mt=$pt | Select-String "($hm)(.+)"
        $pt="~$($mt.matches.groups[2].value)"
    }
    $pt+">> "
}