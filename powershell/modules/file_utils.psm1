function FilterFilesWithoutExtension {
    param ($dir, $ext)
    Get-ChildItem $dir `
    | Where-Object {$_.Name.EndsWith($ext)} `
    | ForEach-Object {$_.BaseName}
}

function FilterFilesWithFullPath {
    param ($dir, $ext)
    Get-ChildItem $dir `
    | Where-Object {$_.Name.EndsWith($ext)} `
    | ForEach-Object {$_.FullName}
}

function CopyFile {
    param ($source, $target)
    New-Item -Force $target | Out-Null
    Copy-Item -Force $source $target
}

function WriteFile {
    param ($target, $content)
    New-Item -Force $target | Out-Null
    Set-Content -Force $target $content
}

Export-ModuleMember -Function *