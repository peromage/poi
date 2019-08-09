# Backup old prompt
function _SAVED_PROMPT {""}
Copy-Item function:prompt function:_SAVED_PROMPT
# Backup old PSReadline color
$_SAVED_PSCOLOR = [ordered]@{
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
}
$_DEFAULT_SCHEME = "default"
$_CURRENT_PROMPT_MOD = ""
$_PROMPTS_DIR = "$PSScriptRoot\styles\prompts\"
$_PSCOLORS_DIR = "$PSScriptRoot\styles\themes\"
$_SCHEMES_DIR = "$PSScriptRoot\styles\themes\schemes\"
$_COLORTOOL = "$PSScriptRoot\styles\themes\ColorTool.exe"

function ChangePrompt([switch]$Restore, $style) {
    if ($Restore) {
        Copy-Item function:_SAVED_PROMPT function:prompt
        Remove-Module $_CURRENT_PROMPT_MOD -ErrorAction Ignore
        return
    }
    $mod = Join-Path $_PROMPTS_DIR "$style.psm1"
    if (Test-Path $mod) {
        Remove-Module $_CURRENT_PROMPT_MOD -ErrorAction Ignore
        Import-Module $mod
        Copy-Item function:PSPrompt function:prompt -ErrorAction SilentlyContinue
        $_CURRENT_PROMPT_MOD = $mod
        return
    }
    Write-Error "No such prompt module exists $mod"
}

function ChangeTheme([switch]$Restore, $style) {
    if ($Restore) {
        Set-PSReadLineOption -Colors $_SAVED_PSCOLOR
        _LoadColorToolScheme $_DEFAULT_SCHEME
        return
    }
    # PSColor is not mandatory
    $col = Join-Path $_PSCOLORS_DIR "$style.psm1"
    if (Test-Path $col) {
        Import-Module $col
        Set-PSReadLineOption -Colors $PSColor -ErrorAction SilentlyContinue
        Remove-Module $col
    }
    _LoadColorToolScheme $style
}

function _LoadColorToolScheme($scheme) {
    # Now colortool has issue detecting schemes.
    # So we have to manually go through different suffixes.
    if (Test-Path $_COLORTOOL) {
        $name = Join-Path $_SCHEMES_DIR $scheme
        $sch = "$name.ini"
        if (Test-Path $sch) {
            Invoke-Expression "$_COLORTOOL -q $sch"
            return
        }
        $sch = "$name.json"
        if (Test-Path $sch) {
            Invoke-Expression "$_COLORTOOL -q $sch"
            return
        }
        $sch = "$name.itermcolors"
        if (Test-Path $sch) {
            Invoke-Expression "$_COLORTOOL -q $sch"
            return
        }
        Write-Error "No such scheme exists $scheme"
        return
    }
    Write-Error "ColorTool does not exist at $_COLORTOOL"
}

Export-ModuleMember -Function ChangePrompt, ChangeTheme