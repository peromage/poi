function gitss { git status }
function gitgg { git log --graph --pretty=format:'%Cred%h%Creset [%an] - %s %Cgreen(%ci)%Creset %C(cyan)%d%Creset' --abbrev-commit --date=relative }
function gitac($msg) { if($msg.length -ne 0){git add -A; git commit -m $msg} else{Write-Output "Usage: gitac <message>"} }