function FilterFilesWithoutExtension($dir, $ext) {
    echo $dir
    Get-ChildItem $dir `
    | Where-Object {$_.Name.EndsWith($ext)} `
    | ForEach-Object {$_.BaseName}
}