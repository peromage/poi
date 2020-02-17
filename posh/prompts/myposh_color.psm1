function prompt {
    $ESC = [char]0x1b
    if ($pwd.Path.ToLower().StartsWith($HOME.ToLower())) {
        $_CWD = "~" + $pwd.Path.Substring($HOME.Length)
    } else{
        $_CWD = $pwd.Path
    }
    if (issu) {
        $_PS1 = ">$ESC[31m${ENV:USERNAME}$ESC[0m@$ESC[34m${ENV:COMPUTERNAME}:$ESC[35m$_CWD$ESC[0m# "
    } else {
        $_PS1 = ">$ESC[33m${ENV:USERNAME}$ESC[0m@$ESC[34m${ENV:COMPUTERNAME}:$ESC[35m$_CWD$ESC[0m$ "
    }
    return $_PS1
}
