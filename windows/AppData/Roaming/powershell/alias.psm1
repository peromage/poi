function gitss { git status }
function gitgg { git log --graph --pretty=format:'%Cred%h%Creset [%an] - %s %Cgreen(%ci)%Creset %C(cyan)%d%Creset' --abbrev-commit --date=relative }
function gitac{ if($args[0]){git add -A; git commit -m $msg} else{Write-Output "Usage: gitac <message>"}}

function touch { if($args[0]){New-Item -ItemType File -Path $args[0]} else{"Usage: touch <file[,file1[,file2...]]>"}}

Export-ModuleMember -Function *