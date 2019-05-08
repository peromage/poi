# Console color test
function Show-ColorTest {
    $width = 7
    $word = "gYm"
    $esc = [char]0x1b

    # print columns with background colors
    # usage: pcbg <word> <color_code>
    function pcbg {
        param($word, $colorcode)
        Write-Host ("{0,$width}" -f $colorcode.Substring(2)) -NoNewline
        Write-Host ("{0,$width}" -f $word) -NoNewline
        foreach ($i in 40..47) {
            Write-Host ("$colorcode$esc[${i}m{0,$width}$esc[0m" -f $word) -NoNewline
        }
        Write-Host
    }

    # header
    Write-Host ("{0,$width} {1,$width}" -f "code", "m") -NoNewline
    foreach ($i in 40..47) {
        Write-Host ("{0,$width}" -f "${i}m") -NoNewline
    }
    Write-Host
    # print row by row
    pcbg $word "$esc[0m"
    pcbg $word "$esc[1m"
    foreach ($i in 30..37) {
        pcbg $word "$esc[${i}m"
        pcbg $word "$esc[1;${i}m"
    }
}

# Console supported colors
function Show-ConsoleColor {
    $colors = [enum]::GetValues([System.ConsoleColor])
    foreach ($bgcolor in $colors){
        foreach ($fgcolor in $colors) { Write-Host "$fgcolor|"  -ForegroundColor $fgcolor -BackgroundColor $bgcolor -NoNewLine }
        Write-Host " on $bgcolor"
    }
}

function Test-Administrator {
    $user = [Security.Principal.WindowsIdentity]::GetCurrent()
    return (New-Object Security.Principal.WindowsPrincipal $user).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}