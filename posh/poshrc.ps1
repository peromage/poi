# Initialize variables
$_loaded_blocks = @("commands", "path")
$_loaded_prompt = "myposh"

#region Functional Blocks
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

    function linktopath {
        param($target,
              $name=(Get-Item $target).Name,
              $bin_path="$HOME\.local\bin")
        New-Item -ItemType SymbolicLink `
                 -Target $target `
                 -Path $bin_path `
                 -Name $name `
                 -Force
    }
}

$_blocks["path"] =
{
    function Add-UserPath {
        param ($path)
        if (Test-UserPath $path) {
            return
        }
        if (-not $path.EndsWith(";")) {
            $path = $path + ";"
        }
        $currPath = Get-UserPath
        if (-not $currPath.EndsWith(";")) {
            $currPath = $currPath + ";"
        }
        $currPath = $currPath + $path
        Set-UserPath $currPath
    }

    function Remove-UserPath {
        param ($path)
        if (-not (Test-UserPath $path)) {
            return
        }
        $currPath = Get-UserPath
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
        Set-UserPath $newPath
    }

    function Test-UserPath {
        param ($path)
        $currPath = Get-UserPath
        $arr = $currPath.Split(';')
        foreach ($i in $arr) {
            if ($i.EndsWith($path)) {
                return $true
            }
        }
        return $false
    }

    function Get-UserPath {
        $path = [System.Environment]::GetEnvironmentVariable(
            "path", [System.EnvironmentVariableTarget]::User)
        if ($null -eq $path) {
            return ""
        }
        return $path
    }

    function Set-UserPath {
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
#endregion

#region Prompts
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

$_prompts["myposh"] =
{
    $ESC = [char]0x1b
    if ($pwd.Path.ToLower().StartsWith($HOME.ToLower())) {
        $_CWD = "~" + $pwd.Path.Substring($HOME.Length)
    } else{
        $_CWD = $pwd.Path
    }
    if (issu) {
        $_PS1 = ">$ESC[31m${ENV:USERNAME}$ESC[0m@${ENV:COMPUTERNAME}:$_CWD# "
    } else {
        $_PS1 = ">$ESC[32m${ENV:USERNAME}$ESC[0m@${ENV:COMPUTERNAME}:$_CWD$ "
    }
    return $_PS1
}
#endregion

#region Don't Touch Below
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
#endregion
