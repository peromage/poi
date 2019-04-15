Set-StrictMode -Off

# set color 
colortool Dracula-Alt | Out-Null

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

    $currPath = (Resolve-Path .).Path
    $currDir = ''
    $userIndicator = '>'
    $userInfo = "$ENV:USERNAME@$ENV:COMPUTERNAME"
    $userColor = "DarkGreen"

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
        $userColor = "DarkRed"
    }
    else {
        $userIndicator = '$'
        $userColor = "DarkGreen"
    }

    # overwrite title
    $Host.ui.RawUI.WindowTitle = $userInfo

    # overwrite prompt
    Write-Host "$userInfo" -NoNewline -ForegroundColor $userColor
    Write-Host ":" -NoNewline -ForegroundColor White
    Write-Host "$currPath" -NoNewline -ForegroundColor DarkBlue
    Write-Host "$currDir" -NoNewline -ForegroundColor DarkBlue
    # Write-Host " ($orgExtCode)" -NoNewline
    Write-Host $("$userIndicator" * ($nestedPromptLevel + 1)) -NoNewline -ForegroundColor White
    # restore exit code
    $LASTEXITCODE = $orgExtCode

    return " "
}