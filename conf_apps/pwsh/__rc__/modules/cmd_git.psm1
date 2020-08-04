# Git functions
function Git-Status {
    git status
}

function Git-Log {
    git log --graph --pretty=format:'%Cred%h%Creset [%an] - %s %Cgreen(%ci)%Creset %C(cyan)%d%Creset' --abbrev-commit --date=relative
}

function Git-AddCommit {
    git add -A
    git commit -m $args[0]
}

function Git-Branch {
    git branch $args
}

function Git-Checkout {
    git checkout $args
}

Set-Alias -Name gst -Value Git-Status
Set-Alias -Name glo -Value Git-Log
Set-Alias -Name gac -Value Git-AddCommit
Set-Alias -Name gch -Value Git-Checkout
Set-Alias -Name gbr -Value Git-Branch

Export-ModuleMember -Function * -Alias *
