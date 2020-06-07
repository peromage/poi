function _pwd_tilde_ {
    if ($pwd.Path.ToLower().StartsWith($HOME.ToLower())) {
        return "~" + $pwd.Path.Substring($HOME.Length)
    }
    return $pwd.Path
}

function prompt {
    Write-Host -NoNewline -ForegroundColor Blue "$(_pwd_tilde_)"
    return " "
}
