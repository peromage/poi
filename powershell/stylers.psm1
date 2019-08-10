Import-Module (Join-Path $PSScriptRoot "defaults.psm1") `
    -Variable SAVEDIR, DEFAULT_SCHEME, DEFAULT_PSCOLORS `
    -Function DEFAULT_PROMPT `
    -ErrorAction Stop
Import-Module (Join-Path $PSScriptRoot "utils.psm1") -ErrorAction Stop

### Variables
$_SAVED_PSCOLOR_PATH = Join-Path $SAVEDIR "saved_pscolor.json"
$_SAVED_SCHEME_PATH = Join-Path $SAVEDIR "saved_scheme.ini"
$_DEFAULT_SCHEME_PATH = Join-Path $SAVEDIR "default_scheme.ini"
$_CURRENT_PROMPT_MOD = ""
$_PROMPTS_DIR = Join-Path $PSScriptRoot "styles\prompts\"
$_PSCOLORS_DIR = Join-Path $PSScriptRoot "styles\themes\"
$_SCHEMES_DIR = Join-Path $PSScriptRoot "styles\themes\schemes\"
$_COLORTOOL = Join-Path $PSScriptRoot "styles\themes\ColorTool.exe"
function _SAVED_PROMPT {""}
### End constants

### Private methods
function ColorTool {
    if (-not (Test-Path $_COLORTOOL)) {
        Write-Host -ForegroundColor Red "ColorTool was not found at: $_COLORTOOL"
        return
    }
    $ctargs = $args -join " "
    Invoke-Expression "$_COLORTOOL $ctargs"
}

function SetPSColorFromJsonFile($file) {
    Set-PSReadLineOption -Colors (ConvertJsonFileToHash $file)
}

function UnloadModule($mod) {
    try {
        Get-Module -Name $mod -ErrorAction Stop | Out-Null
        Remove-Module $mod
    } catch {
        
    }
}
### End private methods

function ChangePrompt([switch]$Save, [switch]$Restore, [switch]$Default, $style) {
    if ($Save) {
        Copy-Item function:prompt function:_SAVED_PROMPT
        return
    }
    if ($Restore) {
        Copy-Item function:_SAVED_PROMPT function:prompt
        UnloadModule $_CURRENT_PROMPT_MOD
        return
    }
    if ($Default) {
        Copy-Item function:DEFAULT_PROMPT function:prompt
        UnloadModule $_CURRENT_PROMPT_MOD
        return
    }
    $mod = Join-Path $_PROMPTS_DIR "$style.psm1"
    if (Test-Path $mod) {
        UnloadModule $_CURRENT_PROMPT_MOD
        Import-Module $mod -Function PSPrompt -ErrorAction Stop
        Copy-Item function:PSPrompt function:prompt
        $_CURRENT_PROMPT_MOD = $mod
        return
    }
    Write-Host -ForegroundColor Red "No such prompt module found: $mod"
}

function ChangeTheme([switch]$Save, [switch]$Restore, [switch]$Default, $style) {
    if ($Save) {
        ColorTool -o $_SAVED_SCHEME_PATH
        ConvertHashToJsonFile `
        @{
            "Command" = (Get-PSReadLineOption).CommandColor
            "Comment" = (Get-PSReadLineOption).CommentColor
            "ContinuationPrompt" = (Get-PSReadLineOption).ContinuationPromptColor
            "Default" = (Get-PSReadLineOption).DefaultTokenColor
            "Emphasis" = (Get-PSReadLineOption).EmphasisColor
            "Error" = (Get-PSReadLineOption).ErrorColor
            "Keyword" = (Get-PSReadLineOption).KeywordColor
            "Member" = (Get-PSReadLineOption).MemberColor
            "Number" = (Get-PSReadLineOption).NumberColor
            "Operator" = (Get-PSReadLineOption).OperatorColor
            "Parameter" = (Get-PSReadLineOption).ParameterColor
            "Selection" = (Get-PSReadLineOption).SelectionColor
            "String" = (Get-PSReadLineOption).StringColor
            "Type" = (Get-PSReadLineOption).TypeColor
            "Variable" = (Get-PSReadLineOption).VariableColor
        } $_SAVED_PSCOLOR_PATH
        return
    }
    if ($Restore) {
        if (Test-Path $_SAVED_PSCOLOR_PATH) {
            SetPSColorFromJsonFile $_SAVED_PSCOLOR_PATH
        }
        else {
            Write-Host -ForegroundColor Red "No saved pscolor found: $_SAVED_PSCOLOR_PATH"
        }
        if (Test-Path $_SAVED_SCHEME_PATH) {
            ColorTool -q $_SAVED_SCHEME_PATH
        }
        else {
            Write-Host -ForegroundColor Red "No saved color scheme found: $_SAVED_SCHEME_PATH"
        }
        return
    }
    if ($Default) {
        SetPSColorFromJsonFile $DEFAULT_PSCOLORS
        Set-Content $_DEFAULT_SCHEME_PATH $DEFAULT_SCHEME
        ColorTool -q $_DEFAULT_SCHEME_PATH
        Remove-Item $_DEFAULT_SCHEME_PATH
        return
    }
    # PSColor is not mandatory
    $col = Join-Path $_PSCOLORS_DIR "$style.json"
    if (Test-Path $col) {
        SetPSColorFromJsonFile $col
    }
    # Now colortool has issue detecting schemes.
    # So we have to manually go through different suffixes.
    $name = Join-Path $_SCHEMES_DIR $style
    $sch = "$name.ini"
    if (Test-Path $sch) {
        ColorTool -q $sch
        return
    }
    $sch = "$name.json"
    if (Test-Path $sch) {
        ColorTool -q $sch
        return
    }
    $sch = "$name.itermcolors"
    if (Test-Path $sch) {
        ColorTool -q $sch
        return
    }
    Write-Host -ForegroundColor Red "No such scheme found: $style"
}

### Doing backup at startup ###
# Backup old prompt
ChangePrompt -Save | Out-Null
# Backup old theme
if ((-not (Test-Path $_SAVED_PSCOLOR_PATH)) -or (-not (Test-Path $_SAVED_SCHEME_PATH))) {
    ChangeTheme -Save | Out-Null
}
### End backup ###

Export-ModuleMember -Function ChangePrompt, ChangeTheme