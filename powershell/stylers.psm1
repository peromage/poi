Import-Module (Join-Path $PSScriptRoot "core.psm1")
Import-Module (Join-Path $PSScriptRoot "json_utils.psm1")
Import-Module (Join-Path $PSScriptRoot "defaults.psm1") `
    -Variable SAVEDIR, DEFAULT_SCHEME, DEFAULT_PSCOLORS `
    -Function DEFAULT_PROMPT `

### Variables
$_SAVED_PSCOLOR_PATH = Join-Path $SAVEDIR "saved_pscolor.json"
$_SAVED_SCHEME_PATH = Join-Path $SAVEDIR "saved_scheme.ini"
$_DEFAULT_SCHEME_PATH = Join-Path $SAVEDIR "default_scheme.ini"
$_CURRENT_PROMPT_MOD = ""
$_PROMPTS_DIR = Join-Path $PSScriptRoot "styles\prompts\"
$_PSCOLORS_DIR = Join-Path $PSScriptRoot "styles\pscolors\"
$_SCHEMES_DIR = Join-Path $PSScriptRoot "styles\schemes\"
$_COLORTOOL = Join-Path $PSScriptRoot "styles\ColorTool.exe"
function _SAVED_PROMPT {""}
### End constants

### Private methods
function ColorTool {
    if (-not (Test-Path $_COLORTOOL)) {
        Write-Output "ColorTool was not found at: $_COLORTOOL"
        return
    }
    $ctargs = $args -join " "
    Invoke-Expression "$_COLORTOOL $ctargs"
}

function SetPSColorFromJson([switch]$File, $json) {
    if ($File) {
        Set-PSReadLineOption -Colors (ConvertJsonFileToHash $json)
    }
    else {
        Set-PSReadLineOption -Colors (ConvertJsonToHash $json)
    }
}

# Recursively unload all prompt modules in prompt dir
function UnloadAllPromptMod {
    Copy-Item function:DEFAULT_PROMPT function:prompt
    $loaded = Get-Module | Where-Object {$_.Path.StartsWith($_PROMPTS_DIR)}
    foreach ($i in $loaded) {
        RiceModule -Unload $i.Name
    }
}
### End private methods

function ChangePrompt([switch]$List, [switch]$Save, [switch]$Restore, [switch]$Default, $style) {
    if ($List) {
        Get-ChildItem $_PROMPTS_DIR | Where-Object {$_.Name.EndsWith('.psm1')} | ForEach-Object {$_.BaseName}
        return
    }
    if ($Save) {
        Copy-Item function:prompt function:_SAVED_PROMPT
        return
    }
    if ($Restore) {
        UnloadAllPromptMod
        Copy-Item function:_SAVED_PROMPT function:prompt
        return
    }
    if ($Default) {
        UnloadAllPromptMod
        return
    }
    $mod = Join-Path $_PROMPTS_DIR "$style.psm1"
    if (Test-Path $mod) {
        UnloadAllPromptMod
        RiceModule -Load -Global -FullPath $mod
        Copy-Item function:PSPrompt function:prompt
        $_CURRENT_PROMPT_MOD = $style
        return
    }
    Write-Output "No such prompt module found: $mod"
}

function ChangeTheme([switch]$List, [switch]$Save, [switch]$Restore, [switch]$Default, $style) {
    if ($List) {
        ColorTool -s
        return
    }
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
            SetPSColorFromJson -File $_SAVED_PSCOLOR_PATH
        }
        else {
            Write-Output "No saved pscolor found: $_SAVED_PSCOLOR_PATH"
        }
        if (Test-Path $_SAVED_SCHEME_PATH) {
            ColorTool -q $_SAVED_SCHEME_PATH
        }
        else {
            Write-Output "No saved color scheme found: $_SAVED_SCHEME_PATH"
        }
        return
    }
    if ($Default) {
        SetPSColorFromJson $DEFAULT_PSCOLORS
        Set-Content $_DEFAULT_SCHEME_PATH $DEFAULT_SCHEME
        ColorTool -q $_DEFAULT_SCHEME_PATH
        Remove-Item $_DEFAULT_SCHEME_PATH
        return
    }
    # PSColor is not mandatory
    $col = Join-Path $_PSCOLORS_DIR "$style.json"
    if (Test-Path $col) {
        SetPSColorFromJson -File $col
    }
    else {
        SetPSColorFromJson $DEFAULT_PSCOLORS
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
    Write-Output "No such scheme found: $style"
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