code.cmd --list-extensions | %{"code.cmd --install-extension $_"} > import-extensions.ps1
