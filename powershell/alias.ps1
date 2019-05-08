function gitss { git status }
function gitgg { git log --graph --pretty=format:'%Cred%h%Creset [%an] - %s %Cgreen(%ci)%Creset %C(cyan)%d%Creset' --abbrev-commit --date=relative }
function gitac($msg) { ($msg.length -ne 0) -and $(git add -A; git commit -m $msg) }