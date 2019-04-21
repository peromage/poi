Set-StrictMode -Off

# variables
# color palette
$ConsolePalette = [ordered]@{
    "30m" = [System.ConsoleColor]::Black
    "31m" = [System.ConsoleColor]::DarkBlue
    "32m" = [System.ConsoleColor]::DarkGreen
    "33m" = [System.ConsoleColor]::DarkCyan
    "34m" = [System.ConsoleColor]::DarkRed
    "35m" = [System.ConsoleColor]::DarkMagenta
    "36m" = [System.ConsoleColor]::DarkYellow
    "37m" = [System.ConsoleColor]::Gray
    "1;30m" = [System.ConsoleColor]::DarkGray
    "1;31m" = [System.ConsoleColor]::Blue
    "1;32m" = [System.ConsoleColor]::Green
    "1;33m" = [System.ConsoleColor]::Cyan
    "1;34m" = [System.ConsoleColor]::Red
    "1;35m" = [System.ConsoleColor]::Magenta
    "1;36m" = [System.ConsoleColor]::Yellow
    "1;37m" = [System.ConsoleColor]::White
    "40m" = [System.ConsoleColor]::Black
    "41m" = [System.ConsoleColor]::DarkBlue
    "42m" = [System.ConsoleColor]::DarkGreen
    "43m" = [System.ConsoleColor]::DarkCyan
    "44m" = [System.ConsoleColor]::DarkRed
    "45m" = [System.ConsoleColor]::DarkMagenta
    "46m" = [System.ConsoleColor]::DarkYellow
    "47m" = [System.ConsoleColor]::Gray
}

# set color pattern 
if(Get-Command colortool -ErrorAction SilentlyContinue) {colortool -q Dracula-Alt}

# set psreadline
Set-PSReadlineOption -Color @{
    "Command" = $ConsolePalette["1;32m"]
    "Parameter" = $ConsolePalette["37m"]
    "Operator" = $ConsolePalette["1;35m"]
    "Variable" = $ConsolePalette["1;37m"]
    "String" = $ConsolePalette["1;36m"]
    "Number" = $ConsolePalette["1;31m"]
    "Type" = $ConsolePalette["1;33m"]
    "Comment" = $ConsolePalette["33m"]
}

function Show-ConsoleColor {
    $colors = [enum]::GetValues([System.ConsoleColor])
    Foreach ($bgcolor in $colors){
        Foreach ($fgcolor in $colors) { Write-Host "$fgcolor|"  -ForegroundColor $fgcolor -BackgroundColor $bgcolor -NoNewLine }
        Write-Host " on $bgcolor"
    }
}

# test admin
function Test-Administrator {
    $user = [Security.Principal.WindowsIdentity]::GetCurrent();
    return (New-Object Security.Principal.WindowsPrincipal $user).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}

function Prompt {
    # backup exit code
    $ret = $LASTEXITCODE

    # give string some colors
    # usage: gssc <word> <color_code>
    function gssc {
        param($word, $colorcode)
        return "$([char]0x1b)[${colorcode}${word}$([char]0x1b)[0m"
    }

    # prompt style generator 1
    function style1 {
        param($symbol, $colorcode)

        # login
        $login = gssc $"$ENV:USERNAME@$ENV:COMPUTERNAME" $colorcode
        # path
        $currpath = gssc $(if($pwd.Path.ToLower().StartsWith($HOME.ToLower())){"~"+$pwd.Path.Substring($HOME.Length)} else{$pwd.Path}) "33m"
        # check last exit status
        $face = if($ret -eq 0){gssc ":)" "32m"} else{gssc ":(" "31m"}

        # overwrite title
        $Host.ui.RawUI.WindowTitle = "$ENV:USERNAME@$ENV:COMPUTERNAME"
        # override prompt
        Write-Host "${login}:${currpath} ${face} $("$symbol" * ($nestedPromptLevel + 1))" -NoNewline
    }

    if(Test-Administrator) {
        style1 "#" "31m"
    }
    else {
        style1 "$" "32m"
    }
    # restore exit code
    $LASTEXITCODE = $ret

    # hide "PS>"
    return " "
}