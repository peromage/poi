Import-Module (Join-Path $PSScriptRoot "constants.psm1") `
    -Variable $SAVEDIR, $DEFAULT_SCHEME, $DEFAULT_PSCOLORS `
    -Function DEFAULT_PROMPT `
    -ErrorAction Stop
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
$_SAVED_SCHEME_PATH = Join-Path $SAVEDIR "saved_scheme.ini"
$_DEFAULT_SCHEME_PATH = Join-Path $SAVEDIR "default_scheme.ini"
$_CURRENT_PROMPT_MOD = ""
$_PROMPTS_DIR = Join-Path $PSScriptRoot "styles\prompts\"
$_PSCOLORS_DIR = Join-Path $PSScriptRoot "styles\themes\"
$_SCHEMES_DIR = Join-Path $PSScriptRoot "styles\themes\schemes\"
$_COLORTOOL = Join-Path $PSScriptRoot "styles\themes\ColorTool.exe"

function ChangePrompt([switch]$Restore, [switch]$Default, [parameter(Mandatory = $true)]$style) {
    if ($Restore) {
        Copy-Item function:_SAVED_PROMPT function:prompt
        Remove-Module $_CURRENT_PROMPT_MOD -ErrorAction Ignore
        return
    }
    if ($Default) {
        Copy-Item function:DEFAULT_PROMPT function:prompt
        Remove-Module $_CURRENT_PROMPT_MOD -ErrorAction Ignore
        return
    }
    $mod = Join-Path $_PROMPTS_DIR "$style.psm1"
    if (Test-Path $mod) {
        Remove-Module $_CURRENT_PROMPT_MOD -ErrorAction Ignore
        Import-Module $mod -Function PSPrompt -ErrorAction Stop
        Copy-Item function:PSPrompt function:prompt
        $_CURRENT_PROMPT_MOD = $mod
        return
    }
    Write-Error "No such prompt module found: $mod"
}

function ChangeTheme([switch]$Restore, [switch]$Default, [parameter(Mandatory = $true)]$style) {
    if ($Restore) {
        Set-PSReadLineOption -Colors $_SAVED_PSCOLOR
        Invoke-Expression "$_COLORTOOL -q $_SAVED_SCHEME_PATH"
        return
    }
    if ($Default) {
        Set-PSReadLineOption -Colors $DEFAULT_PSCOLORS
        Set-Content $_DEFAULT_SCHEME_PATH $DEFAULT_SCHEME
        Invoke-Expression "$_COLORTOOL -q $_DEFAULT_SCHEME_PATH"
        return
    }
    # PSColor is not mandatory
    $col = Join-Path $_PSCOLORS_DIR "$style.psm1"
    if (Test-Path $col) {
        Import-Module $col -Variable $PSColor -ErrorAction Stop
        Set-PSReadLineOption -Colors $PSColor
        Remove-Module $col
    }
    # Now colortool has issue detecting schemes.
    # So we have to manually go through different suffixes.
    if (Test-Path $_COLORTOOL) {
        $name = Join-Path $_SCHEMES_DIR $style
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
        Write-Error "No such scheme found: $style"
        return
    }
    Write-Error "ColorTool was not found: $_COLORTOOL"
}

Export-ModuleMember -Function ChangePrompt, ChangeTheme