function FilterFilesWithoutExtension($dir, $ext) {
    Get-ChildItem $dir `
    | Where-Object {$_.Name.EndsWith($ext)} `
    | ForEach-Object {$_.BaseName}
}