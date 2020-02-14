# Initialize variables
$_loaded_blocks = @("commands")
$_loaded_prompt = "linux"

#####################
# Functional blocks #
#####################
$_blocks = @{}

$_blocks["commands"] =
{
    function touch {
        if($args[0]) {
            New-Item -ItemType File -Path $args[0]
        } else {
            "Usage: touch <file[,file1[,file2...]]>"
        }
    }

    function vim {
        if($args.Length -eq 0) {
            bash -c "vim"
        } else {
            bash -c "vim $($args[0].Replace("\", "/"))"}
        }

    function ll {
        Get-ChildItem $args[0] `
        | Select-Object Mode,Length,LastWriteTime,Name,Target `
        | Format-Table -AutoSize
    }

    function issu {
        $ADMIN = (
            [Security.Principal.WindowsPrincipal] `
            [Security.Principal.WindowsIdentity]::GetCurrent()`
            ).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
        return $ADMIN
    }

    function sudo {
        if (issu) {
            Write-Output "Already as admin!"
        } else {
            if ($args.Length -eq 0) {
                Write-Output "Usage: sudo <command> [arguments]"
            } elseif ($args.Length -ge 1) {
                $commands = "-noexit -command cd $pwd;" + ($args -join ' ')
                $proc = New-Object -TypeName System.Diagnostics.Process
                $proc.StartInfo.FileName = "powershell.exe"
                $proc.StartInfo.Arguments = $commands
                $proc.StartInfo.UseShellExecute = $true
                $proc.StartInfo.Verb = "runas"
                $proc.Start() | Out-Null
            }
        }
    }

    function su {
        if (issu) {
            Write-Output "Already as admin!"
        } else {
            $commands = "-noexit -command cd $pwd;"
            $proc = New-Object -TypeName System.Diagnostics.Process
            $proc.StartInfo.FileName = "powershell.exe"
            $proc.StartInfo.Arguments = $commands
            $proc.StartInfo.UseShellExecute = $true
            $proc.StartInfo.Verb = "runas"
            $proc.Start() | Out-Null
        }
    }
}

$_blocks["path_helpers"] =
{
    function Add-EnvUserPath {
        param ($path)
        if (Test-EnvUserPath $path) {
            return
        }
        if (-not $path.EndsWith(";")) {
            $path = $path + ";"
        }
        $currPath = Get-EnvUserPath
        if (-not $currPath.EndsWith(";")) {
            $currPath = $currPath + ";"
        }
        $currPath = $currPath + $path
        Set-EnVUserPath $currPath
    }

    function Remove-EnvUserPath {
        param ($path)
        if (-not (Test-EnvUserPath $path)) {
            return
        }
        $currPath = Get-EnvUserPath
        $arr = $currPath.Split(';')
        $newPath = ""
        foreach ($i in $arr) {
            if ($i.EndsWith($path)) {
                continue
            }
            if ($i -eq "") {
                continue
            }
            $newPath = $newPath + $i + ";"
        }
        Set-EnVUserPath $newPath
    }

    function Test-EnvUserPath {
        param ($path)
        $currPath = Get-EnvUserPath
        $arr = $currPath.Split(';')
        foreach ($i in $arr) {
            if ($i.EndsWith($path)) {
                return $true
            }
        }
        return $false
    }

    function Get-EnvUserPath {
        $path = [System.Environment]::GetEnvironmentVariable(
            "path", [System.EnvironmentVariableTarget]::User)
        if ($null -eq $path) {
            return ""
        }
        return $path
    }

    function Set-EnVUserPath {
        param ($path)
        if (-not $path.EndsWith(";")) {
            $path = $path + ";"
        }
        [System.Environment]::SetEnvironmentVariable(
            "path", $path, [System.EnvironmentVariableTarget]::User)
        Update-EnvPath
    }

    function Update-EnvPath {
        $env:Path = @(
            [System.Environment]::GetEnvironmentVariable(
                "path", [System.EnvironmentVariableTarget]::Machine),
            [System.Environment]::GetEnvironmentVariable(
                "path", [System.EnvironmentVariableTarget]::User)) -join ";"
    }
}

##########
# Prompt #
##########
$_prompts = @{}

$_prompts["cmder"] =
{
    $_PS1 = ""
    $_TITLE = ""
    $ESC = [char]0x1b
    if (issu) {
        $_PS1 = '" $ESC[31m$pwd$ESC[0m`n !> "'
        $_TITLE = "Administrator:$ENV:USERNAME@$ENV:COMPUTERNAME"
    } else {
        $_PS1 = '" $ESC[32m$pwd$ESC[0m`n > "'
        $_TITLE = "$ENV:USERNAME@$ENV:COMPUTERNAME"
    }
    $Host.ui.RawUI.WindowTitle = $_TITLE
    return Invoke-Expression $_PS1
}

$_prompts["linux"] =
{
    $_PS1 = ""
    $_TITLE = ""
    $ESC = [char]0x1b
    function _PWD_HOME_TILDE_ {
        $p = (Get-Item .).FullName
        if ($p.ToLower().StartsWith($HOME.ToLower())) { Write-Output ("~" + $p.Substring($HOME.Length))}
        else { Write-Output $p }
    }
    function _PWD_HOME_TILDE_DIR_ {
        $p = (Get-Item .).BaseName
        if ($p.ToLower() -eq $ENV:USERNAME.ToLower()) { Write-Output "~" }
        else { Write-Output $p }
    }

    if (issu) {
        $_PS1 = '"[$ESC[31m${ENV:USERNAME}$ESC[0m@${ENV:COMPUTERNAME}:$(_PWD_HOME_TILDE_DIR_)]# "'
        $_TITLE = "Administrator:$ENV:USERNAME@$ENV:COMPUTERNAME"
    }
    else {
        $_PS1 = '"[$ESC[32m${ENV:USERNAME}$ESC[0m@${ENV:COMPUTERNAME}:$(_PWD_HOME_TILDE_DIR_)]$ "'
        $_TITLE = "$ENV:USERNAME@$ENV:COMPUTERNAME"
    }

    $Host.ui.RawUI.WindowTitle = $_TITLE
    return Invoke-Expression $_PS1
}

################################################################################
# DO NOT TOUCH BELOW ###########################################################
################################################################################
# Initialize registered blocks
foreach ($blk in $_loaded_blocks) {
    $b = $_blocks[$blk]
    if ($null -ne $b) {
        . $b
    }
}

# Initialize styles
$_prpt = $_prompts[$_loaded_prompt]
if ($null -ne $_prpt) {
    function global:prompt {
        $_prpt.Invoke()
    }
}

# Clean up
Remove-Variable _loaded_blocks
Remove-Variable _loaded_prompt
Remove-Variable _prompts
Remove-Variable _blocks
