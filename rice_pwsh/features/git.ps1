<#
.SYNOPSIS
Git aliases.
Modified by peromage on 2021/01/24
#>

function Send-GitStatus {
    git status
}

function Send-GitLog {
    git log --graph --pretty=format:'%Cred%h%Creset [%an] - %s %Cgreen(%ci)%Creset %C(cyan)%d%Creset' --abbrev-commit --date=relative
}

function Send-GitAddnCommit {
    git add -A
    git commit -m $args[0]
}

function Send-GitBranch {
    git branch $args
}

function Send-GitCheckout {
    git checkout $args
}

Set-Alias gst Send-GitStatus
Set-Alias glo Send-GitLog
Set-Alias gac Send-GitAddnCommit
Set-Alias gbr Send-GitBranch
Set-Alias gch Send-GitCheckout
