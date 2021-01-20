<#
.SYNOPSIS
Git aliases.
Modified by peromage on 2021/01/20
#>
function GitStatus {
    git status
}

function GitLog {
    git log --graph --pretty=format:'%Cred%h%Creset [%an] - %s %Cgreen(%ci)%Creset %C(cyan)%d%Creset' --abbrev-commit --date=relative
}

function GitAddCommit {
    git add -A
    git commit -m $args[0]
}

function GitBranch {
    git branch $args
}

function GitCheckout {
    git checkout $args
}

Set-Alias -Name gst -Value GitStatus
Set-Alias -Name glo -Value GitLog
Set-Alias -Name gac -Value GitAddCommit
Set-Alias -Name gch -Value GitCheckout
Set-Alias -Name gbr -Value GitBranch

Export-ModuleMember -Function * -Alias *
