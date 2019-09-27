function Show-FilesWithoutExtension {
    param ($dir, $ext)
    Get-ChildItem $dir `
    | Where-Object {$_.Name.EndsWith($ext)} `
    | ForEach-Object {$_.BaseName}
}

function Show-FilesWithFullPath {
    param ($dir, $ext)
    Get-ChildItem $dir `
    | Where-Object {$_.Name.EndsWith($ext)} `
    | ForEach-Object {$_.FullName}
}

function Copy-File {
    param ($source, $target)
    New-Item -Force $target | Out-Null
    Copy-Item -Force $source $target
}

function Write-File {
    param ($target, $content)
    New-Item -Force $target | Out-Null
    Set-Content -Force $target $content
}

Export-ModuleMember -Function *
