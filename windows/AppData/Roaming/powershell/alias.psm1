function gitss { git status }

function gitgg { git log --graph --pretty=format:'%Cred%h%Creset [%an] - %s %Cgreen(%ci)%Creset %C(cyan)%d%Creset' --abbrev-commit --date=relative }

function gitac{ if($args[0]){git add -A; git commit -m $args[0]} else{Write-Output "Usage: gitac <message>"} }

function touch { if($args[0]){New-Item -ItemType File -Path $args[0]} else{"Usage: touch <file[,file1[,file2...]]>"} }

function vim { if($args.Length -eq 0){bash -c "vim"} else{bash -c "vim $($args[0].Replace("\", "`/"))"} }

function ll { Get-ChildItem $args[0] | Select-Object Mode,Length,LastWriteTime,Name,Target | Format-Table -AutoSize }

Export-ModuleMember -Function *