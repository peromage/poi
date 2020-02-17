function prompt {
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
