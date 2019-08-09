function THEME_SETTER {
    param($ColorToolArgs, $PSReadlineArgs)

    $COLORTOOL = "$PSScriptRoot\colortool\ColorTool.exe"
    $DEFAULTCOLORS = @{
        "Command" = "$([char]0x1b)[93m"
        "Comment" = "$([char]0x1b)[32m"
        "ContinuationPrompt" = "$([char]0x1b)[37m"
        "Default" = "$([char]0x1b)[37m"
        "Emphasis" = "$([char]0x1b)[96m"
        "Error" = "$([char]0x1b)[91m"
        "Keyword" = "$([char]0x1b)[92m"
        "Member" = "$([char]0x1b)[97m"
        "Number" = "$([char]0x1b)[97m"
        "Operator" = "$([char]0x1b)[90m"
        "Parameter" = "$([char]0x1b)[90m"
        "Selection" = "$([char]0x1b)[30;47m"
        "String" = "$([char]0x1b)[36m"
        "Type" = "$([char]0x1b)[37m"
        "Variable" = "$([char]0x1b)[92m"
    }

    # only apply scheme when colortool exists
    if (Test-Path $COLORTOOL) {
        if ($ColorToolArgs) { Invoke-Expression "$COLORTOOL -q $ColorToolArgs" }
        # apply psreadline 
        [System.Console]::ResetColor()
        if ($PSReadlineArgs) { Set-PSReadlineOption -colors $PSReadlineArgs }
        else { Set-PSReadlineOption -colors $DEFAULTCOLORS }
    }
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
                "Type" = [ConsoleColor]::Cyan
                "Comment" = [ConsoleColor]::DarkCyan
            }
            THEME_SETTER "Dracula-Alt.itermcolors" $colors
            break
        }
        "solarized-dark" { THEME_SETTER "solarized_dark.itermcolors"; break }
        "solarized-light" { THEME_SETTER "solarized_light.itermcolors"; break }
        "campbell" { THEME_SETTER "campbell.ini"; break }
        "campbell-legacy" { THEME_SETTER "campbell-legacy.ini"; break }
        "cmd-legacy" { THEME_SETTER "cmd-legacy.ini"; break }
        "onehalf-dark" { THEME_SETTER "OneHalfDark.itermcolors"; break }
        "onehalf-light" { THEME_SETTER "OneHalfLight.itermcolors"; break }
        "deuteranopia" { THEME_SETTER "deuteranopia.itermcolors"; break }
    }
}

Export-ModuleMember -Function THEME_SELECTOR, THEME_SETTER -Variable CONSOLE_PALETTE