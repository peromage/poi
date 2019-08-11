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

    $dir = [System.IO.Path]::GetDirectoryName($target)
    if (-not (Test-Path $dir)) {
        New-Item -ItemType Directory $dir
    }
    Copy-Item -Force $source $target
}

function WriteFile {
    param ($target, $content)

    $dir = [System.IO.Path]::GetDirectoryName($target)
    if (-not (Test-Path $dir)) {
        New-Item -ItemType Directory $dir
    }
    Set-Content -Force $target $content
}

Export-ModuleMember -Function *