# Default PSReadline color scheme
$DEFAULT_PSCOLORS = @"
{
    "Command":  "\u001b[93m",
    "Comment":  "\u001b[32m",
    "ContinuationPrompt":  "\u001b[37m",
    "Default":  "\u001b[37m",
    "Emphasis":  "\u001b[96m",
    "Error":  "\u001b[91m",
    "Keyword":  "\u001b[92m",
    "Member":  "\u001b[97m",
    "Number":  "\u001b[97m",
    "Operator":  "\u001b[90m",
    "Parameter":  "\u001b[90m",
    "Selection":  "\u001b[30;47m",
    "String":  "\u001b[36m",
    "Type":  "\u001b[37m",
    "Variable":  "\u001b[92m"
}
"@

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

$MyBin = @"
{
    "tc":  "totalcommander\\TOTALCMD64.EXE",
    "chrome":  "chrome\\chrome.exe",
    "jcp":  "jcpicker\\jcpicker.exe",
    "picpick":  "picpick\\picpick.exe",
    "aria2":  "aria2\\aria2c.exe",
    "bash":  "git\\bin\\bash.exe",
    "7z":  "7-zip\\7zFM.exe",
    "git":  "git\\bin\\git.exe",
    "vlc":  "vlc\\vlc.exe",
    "code":  "vscode\\bin\\code.cmd",
    "npp":  "notepad++\\notepad++.exe",
    "vnc":  "vncviewer\\vncviewer.exe"
}
"@

# Default style
function DEFAULT_PROMPT {
    return "PS $pwd> "
}

# Local save dir
$SAVEDIR = Join-Path $PSScriptRoot "..\.save\"
# Saved files


Export-ModuleMember -Variable * -Function *