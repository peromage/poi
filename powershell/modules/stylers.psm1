Import-Module (Join-Path $PSScriptRoot "json_helpers.psm1")
Import-Module (Join-Path $PSScriptRoot "file_helpers.psm1") `
    -Function Show-FilesWithoutExtension, Write-File
Import-Module (Join-Path $PSScriptRoot "defaults.psm1") `
    -Variable DEFAULT_SCHEME, DEFAULT_PSCOLORS, SAVED_SCHEME_PATH, SAVED_PSCOLOR_PATH, `
        COLORTOOL, PROMPTS_DIR, PSCOLORS_DIR, SCHEMES_DIR `
    -Function DEFAULT_PROMPT `

### Private methods
function _SAVED_PROMPT {""}

function SetPSColorFromJson {
    param ([switch]$File, $json)
    if ($File) {
        Set-PSReadLineOption -Colors (Convert-JsonFileToHash $json)
    }
    else {
        Set-PSReadLineOption -Colors (Convert-JsonToHash $json)
    }
}

# Recursively unload all prompt modules in prompt dir
function UnloadAllPromptMod {
    Copy-Item function:DEFAULT_PROMPT function:prompt
    $loaded = Get-Module | Where-Object {$_.Path.StartsWith($PROMPTS_DIR)}
    foreach ($i in $loaded) {
        Remove-Module $i.Name
    }
}
### End private methods

function ColorTool {
    if (-not (Test-Path $COLORTOOL)) {
        Write-Output "ColorTool was not found at: $COLORTOOL"
        return
    }
    $ctargs = $args -join " "
    Invoke-Expression "$COLORTOOL $ctargs"
}

function RicePrompt {
    param ([switch]$List, [switch]$Save, [switch]$Restore, [switch]$Default, $style)

    if ($List) {
        Show-FilesWithoutExtension $PROMPTS_DIR ".psm1"
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
    UnloadAllPromptMod
    $mod = Join-Path $PROMPTS_DIR "$style.psm1"
    if (Test-Path $mod) {
        Import-Module $mod -Function PSPrompt
        Copy-Item function:PSPrompt function:prompt
        $_CURRENT_PROMPT_MOD = $style
        return
    }
    Write-Output "No such prompt module found: $mod"
}

function RiceTheme {
    param ([switch]$List, [switch]$Save, [switch]$Restore, [switch]$Default, $style)

    if ($List) {
        ColorTool -s
        return
    }
    if ($Save) {
        Convert-HashToJsonFile $SAVED_PSCOLOR_PATH `
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
        }
        ColorTool -o $SAVED_SCHEME_PATH
        return
    }
    if ($Restore) {
        if (Test-Path $SAVED_PSCOLOR_PATH) {
            SetPSColorFromJson -File $SAVED_PSCOLOR_PATH
        }
        else {
            Write-Output "No saved pscolor found: $SAVED_PSCOLOR_PATH"
        }
        if (Test-Path $SAVED_SCHEME_PATH) {
            ColorTool -q $SAVED_SCHEME_PATH
        }
        else {
            Write-Output "No saved color scheme found: $SAVED_SCHEME_PATH"
        }
        return
    }
    if ($Default) {
        SetPSColorFromJson $DEFAULT_PSCOLORS
        $def = Join-Path $SCHEMES_DIR ".default.ini"
        Write-File $def $DEFAULT_SCHEME
        ColorTool -q $def
        Remove-Item $def
        return
    }
    # PSColor is not mandatory
    $col = Join-Path $PSCOLORS_DIR "$style.json"
    if (Test-Path $col) {
        SetPSColorFromJson -File $col
    }
    else {
        SetPSColorFromJson $DEFAULT_PSCOLORS
    }
    # Now colortool has issue detecting schemes.
    # So we have to manually go through different suffixes.
    $name = Join-Path $SCHEMES_DIR $style
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

Export-ModuleMember -Function RicePrompt, RiceTheme, ColorTool
