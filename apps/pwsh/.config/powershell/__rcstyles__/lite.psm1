function _pwd_tilde_ {
    if ($pwd.Path.ToLower().StartsWith($HOME.ToLower())) {
        return "~" + $pwd.Path.Substring($HOME.Length)
    }
    return $pwd.Path
}

function _is_admin_ {
    return (
        [Security.Principal.WindowsPrincipal] `
        [Security.Principal.WindowsIdentity]::GetCurrent()`
        ).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}

function prompt {
    $cwd = _pwd_tilde_

    if (_is_admin_) {
        Write-Host -NoNewline -ForegroundColor Red "! $cwd"
    } else {
        Write-Host -NoNewline -ForegroundColor Green "> $cwd"
    }
    return " "
}

Export-ModuleMember -Function prompt
