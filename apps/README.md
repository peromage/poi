## Default Configuration Paths

### git
Add content to `~/.gitconfig`:
```
[include]
    # On Windows
    #path = "X:/path/to/gitrc"
    # On Linux
    path = "/path/to/gitrc"
```

### totalcmd
`%APPDATA%\GHISLER`

### vim
Add content to `~/.vimrc` or on Windows `%USERPROFILE%\_vimrc`:
```
source PATH_TO_vimrc
```

### vscode
- **Windows**
  - *userdata*: `%APPDATA%\Code\`
  - *extensions*: `%USERPROFILE%\.vscode\extensions\`
- **Linux**
  - *userdata*: `~/.config/Code/`
  - *extensions*: `~/.vscode/extensions/`
- **Portable**
  - *userdata*: `INSTALLATION_DIR/data/user-data/`
  - *extensions*: `INSTALLATION_DIR/data/extensions/`

### tigervnc/
`~/.vnc/`

## Linux Services Path

### systemd
- *system*: `/etc/systemd/system/`
- *user*: `~/.config/systemd/user/`

### netctl
- *system*: `/etc/netctl/`

## Windows Services Path

### task scheduler
- *system*: `C:\etc\tasks`
- *user*: `~\.config\tasks`
