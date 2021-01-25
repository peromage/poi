# Rice PowerShell Configuration

## Usage

Rename `template_init.ps1` to `init.ps1` and then source it.

All customizations should gp into that `init.ps1` file.

```powershell
$ . path/to/init.ps1
```

## Configuration Locations

Get configuration file location for different scopes.

- *AllUsersAllHosts*: `$PROFILE.AllUsersAllHosts`
- *AllUsersCurrentHost*: `$PROFILE.AllUsersCurrentHost`
- *CurrentUserAllHosts*: `$PROFILE.CurrentUserAllHosts`
- *CurrentUserCurrentHost*: `$PROFILE.CurrentUserCurrentHost`

## Directories For Module Rice

- *base*: Essential scripts. Required on all platforms.
- *base_win*: Windows related scripts.
- *features*: Additional features for advanced usage.
- *themes*: CLI themes
- *src*: Source code written other than PowerShell scripts, DotNet usually.
- *scripts*: This directory will be added to PATH so any PowerShell script can be dropped in and invoked at any time.
