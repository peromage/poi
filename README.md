# Working Environment Configuration

## Default Paths

### git/
> *\**: `ANYWHERE`

Add content to `~/.gitconfig`:
```
[include]
    # On Windows
    #path = "X:/PATH_TO_gitrc"
    path = "PATH_TO_gitrc"
```

### powershell/
> *\**: `ANYWHERE`

Get configuration file location for different scope  
- *AllUsersAllHosts*: `$PROFILE.AllUsersAllHosts`  
- *AllUsersCurrentHost*: `$PROFILE.AllUsersCurrentHost`  
- *CurrentUserAllHosts*: `$PROFILE.CurrentUserAllHosts`  
- *CurrentUserCurrentHost*: `$PROFILE.CurrentUserCurrentHost`  

Add content to the configuration file above:
```
. PATH_TO_poshrc.ps1
```

### bash/
> *\**: `ANYWHERE`

Add content to `~/.bashrc`:
```
source PATH_TO_bashrc.sh
```

### totalcommander/
> *default.bar*: `%APPDATA%\GHISLER`
> *wincmd.ini*: `%APPDATA%\GHISLER`

### vim/
> *\**: `ANYWHERE`

Add content to `~/.vimrc` or on Windows `~\_vimrc`:
```
source PATH_TO_vimrc
```

### vscode-portable
user data: `%dir%/data/user-data/`  
extensions: `%dir$/data/extensions/`  

### vscode/
- **Windows**
  - *userdata\\\**: `%APPDATA%\Code\`
  - *extensions\\\**: `%USERPROFILE%\.vscode\extensions\`
- **Linux** 
  - *userdata/\**: `~/.config/Code/`
  - *extensions/\**: `~/.vscode/extensions/`
- **Portable**
  - *userdata/\**: `INSTALLATION_DIR/data/user-data/`
  - *extensions/\**: `INSTALLATION_DIR/data/extensions/`


### i3/
> *\**: `~/.config/i3/`

### frp/
> *\**: `ANYWHERE`

### x/
> *.Xresources*: `~/`

### tigervnc/
> *\**: ~/.vnc/

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