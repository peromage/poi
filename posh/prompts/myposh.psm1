function prompt {
    $ESC = [char]0x1b
    if ($pwd.Path.ToLower().StartsWith($HOME.ToLower())) {
        $_CWD = "~" + $pwd.Path.Substring($HOME.Length)
    } else{
        $_CWD = $pwd.Path
    }
    if (issu) {
        $_PS1 = ">$ESC[31m${ENV:USERNAME}@${ENV:COMPUTERNAME}:$ESC[0m$_CWD# "
    } else {
        $_PS1 = ">$ESC[32m${ENV:USERNAME}@${ENV:COMPUTERNAME}:$ESC[0m$_CWD$ "
    }
    return $_PS1
}
