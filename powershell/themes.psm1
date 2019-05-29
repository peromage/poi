# color palette
$CONSOLE_PALETTE = [ordered]@{
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

function SET_SCHEME {
    param($ColorToolArgs, $PSReadlineArgs)

    $COLORTOOL = "$PSScriptRoot\colortool\ColorTool.exe"
    $DEFAULTCOLORS = @{
        "CommandColor" = "$([char]0x1b)[93m"
        "CommentColor" = "$([char]0x1b)[32m"
        "ContinuationPromptColor" = "$([char]0x1b)[37m"
        "DefaultTokenColor" = "$([char]0x1b)[37m"
        "EmphasisColor" = "$([char]0x1b)[96m"
        "ErrorColor" = "$([char]0x1b)[91m"
        "KeywordColor" = "$([char]0x1b)[92m"
        "MemberColor" = "$([char]0x1b)[97m"
        "NumberColor" = "$([char]0x1b)[97m"
        "OperatorColor" = "$([char]0x1b)[90m"
        "ParameterColor" = "$([char]0x1b)[90m"
        "SelectionColor" = "$([char]0x1b)[30;47m"
        "StringColor" = "$([char]0x1b)[36m"
        "TypeColor" = "$([char]0x1b)[37m"
        "VariableColor" = "$([char]0x1b)[92m"
    }

    # only apply scheme when colortool exists
    if (Test-Path $COLORTOOL) {
        if ($ColorToolArgs) { Invoke-Expression "$COLORTOOL -q $ColorToolArgs" }
        # apply psreadline 
        [System.Console]::ResetColor()
        if ($PSReadlineArgs) { Set-PSReadlineOption -colors $PSReadlineArgs }
        else { Set-PSReadlineOption -colors $DEFAULTCOLORS }
        return 0
    }
    return -1
}

function THEME_SELECTOR {
    param($Scheme)

    # make a choice
    switch ($Scheme) {
        "dracula" {
            $colors = @{
                "Command" = [ConsoleColor]::Green
                "Parameter" = [ConsoleColor]::Gray
                "Operator" = [ConsoleColor]::Magenta
                "Variable" = [ConsoleColor]::White
                "String" = [ConsoleColor]::Yellow
                "Number" = [ConsoleColor]::Blue
                "Type" = [ConsoleColor]::Cxyan
                "Comment" = [ConsoleColor]::DarkCyan
            }
            SET_SCHEME "Dracula-Alt.itermcolors" $colors
            break
        }
        "solarized-dark" { SET_SCHEME "solarized_dark.itermcolors"; break }
        "solarized-light" { SET_SCHEME "solarized_light.itermcolors"; break }
        "campbell" { SET_SCHEME "campbell.ini"; break }
        "campbell-legacy" { SET_SCHEME "campbell-legacy.ini"; break }
        "cmd-legacy" { SET_SCHEME "cmd-legacy.ini"; break }
        "onehalf-dark" { SET_SCHEME "OneHalfDark.itermcolors"; break }
        "onehalf-light" { SET_SCHEME "OneHalfLight.itermcolors"; break }
        "deuteranopia" { SET_SCHEME "deuteranopia.itermcolors"; break }
    }
}

Export-ModuleMember -Function THEME_SELECTOR, SET_SCHEME -Variable CONSOLE_PALETTE