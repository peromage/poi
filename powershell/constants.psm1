# Color palette
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

# Default PSReadline color scheme
$DEFAULT_PSCOLORS = [ordered]@{
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

# Default color theme (ini format)
$DEFAULT_SCHEME = @"
[table]
DARK_BLACK = 38,40,53
DARK_BLUE = 188,146,248
DARK_GREEN = 79,249,123
DARK_CYAN = 97,114,164
DARK_RED = 255,84,84
DARK_MAGENTA = 255,121,197
DARK_YELLOW = 255,183,108
DARK_WHITE = 247,247,241
BRIGHT_BLACK = 84,84,84
BRIGHT_BLUE = 188,146,248
BRIGHT_GREEN = 79,249,123
BRIGHT_CYAN = 138,232,252
BRIGHT_RED = 255,84,84
BRIGHT_MAGENTA = 255,121,197
BRIGHT_YELLOW = 240,249,139
BRIGHT_WHITE = 255,255,255

[screen]
FOREGROUND = DARK_WHITE
BACKGROUND = DARK_BLACK

[popup]
FOREGROUND = DARK_CYAN
BACKGROUND = BRIGHT_WHITE
"@

$MyBin = @{
    "7z" = "7-zip\7zFM.exe"
    "aria2" = "aria2\aria2c.exe"
    "git" = "git\bin\git.exe"
    "bash" = "git\bin\bash.exe"
    "jcp" = "jcpicker\jcpicker.exe"
    "picpick" = "picpick\picpick.exe"
    "vnc" = "vncviewer\vncviewer.exe"
    "tc" = "totalcommander\TOTALCMD64.EXE"
    "code" = "vscode\bin\code.cmd"
    "vlc" = "vlc\vlc.exe"
    "chrome" = "chrome\chrome.exe"
    "npp" = "notepad++\notepad++.exe"
}

# Default style
function DEFAULT_PROMPT {
    return "PS $pwd> "
}

# Escape sequence
$ESC = [char]0x1b

# Local save dir
$SAVEDIR = Join-Path $PSScriptRoot "..\.save\"

Export-ModuleMember -Variable * -Function *