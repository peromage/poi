Set-StrictMode -Off

# set color 
if(Get-Command colortool -ErrorAction SilentlyContinue) {colortool Dracula-Alt | Out-Null}

Set-PSReadlineOption -Color @{
    "Command" = [ConsoleColor]::Green
    "Parameter" = [ConsoleColor]::Gray
    "Operator" = [ConsoleColor]::Magenta
    "Variable" = [ConsoleColor]::White
    "String" = [ConsoleColor]::Yellow
    "Number" = [ConsoleColor]::Blue
    "Type" = [ConsoleColor]::Cyan
    "Comment" = [ConsoleColor]::DarkCyan
}

function Get-AllColors {
    $colors = [enum]::GetValues([System.ConsoleColor])
    Foreach ($bgcolor in $colors){
        Foreach ($fgcolor in $colors) { Write-Host "$fgcolor|"  -ForegroundColor $fgcolor -BackgroundColor $bgcolor -NoNewLine }
        Write-Host " on $bgcolor"
    }
}

function Test-Administrator {
    $user = [Security.Principal.WindowsIdentity]::GetCurrent();
    (New-Object Security.Principal.WindowsPrincipal $user).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}

function Prompt {
    # backup exit code
    $orgExtCode = $LASTEXITCODE

    # color patterns
    $palette=@{
        "Normal" = "White"
        "Warning" = "DarkRed"
        "OK" = "DarkGreen"
        "PathPrimary" = "DarkBlue"
        "PathSecondary" = "Cyan"
    }
    
    $currPath = (Resolve-Path .).Path
    $currDir = ''
    $userIndicator = '>'
    $userInfo = "$ENV:USERNAME@$ENV:COMPUTERNAME"
    $userColor = "Normal"
    $extIndicator = ':|'
    $extcolor = "Normal"

    # replace home dir with ~
    if($currPath.ToLower().StartsWith($HOME.ToLower())) {
        $currPath = '~' + $currPath.Substring($HOME.Length)
    }
    # get current dir and parent path when not at home or root
    if($currPath -match '^(.+\\)([^\\]+)$') {
        $currPath = $Matches[1]
        $currDir = $Matches[2]
    }
    else {
        $currDir = $currPath
        $currPath = ''
    }
    # check if current user is admin
    if(Test-Administrator) {
        $userIndicator = '#'
        $userColor = "Warning"
    }
    else {
        $userIndicator = '$'
        $userColor = "OK"
    }
    # check last exit status
    if($orgExtCode -eq 0) {
        $extIndicator = ':)'
        $extcolor = "OK"
    }
    else {
        $extIndicator = ':('
        $extcolor = "Warning"
    }

    # overwrite title
    $Host.ui.RawUI.WindowTitle = $userInfo

    # overwrite prompt
    Write-Host "$userInfo" -NoNewline -ForegroundColor $palette[$userColor]
    Write-Host ":" -NoNewline -ForegroundColor $palette["Normal"]
    # parent path and current dir can be set to different colors
    Write-Host "$currPath" -NoNewline -ForegroundColor $palette["PathPrimary"]
    Write-Host "$currDir" -NoNewline -ForegroundColor $palette["PathPrimary"]
    Write-Host " $extIndicator" -NoNewline -ForegroundColor $palette[$extcolor]
    Write-Host $(" $userIndicator" * ($nestedPromptLevel + 1)) -NoNewline -ForegroundColor $palette["Normal"]
    # restore exit code
    $LASTEXITCODE = $orgExtCode

    return " "
}