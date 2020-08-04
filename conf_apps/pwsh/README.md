# Rice PowerShell Configuration

## Usage

Rename `init-template.ps1` to `init.ps1` and then source it.

Make your own changes in the `init.ps1` file.

```powershell
$ . path/to/init.ps1
```

## Configuration Locations

Get configuration file location for different scope

- *AllUsersAllHosts*: `$PROFILE.AllUsersAllHosts`
- *AllUsersCurrentHost*: `$PROFILE.AllUsersCurrentHost`
- *CurrentUserAllHosts*: `$PROFILE.CurrentUserAllHosts`
- *CurrentUserCurrentHost*: `$PROFILE.CurrentUserCurrentHost`

## Directories

- *__rc__*: Auto loaded scripts.
- *__rcmodules__*: Manually loaded scripts.
- *__rcsrc__*: Dotnet source code.
- *__rcstyles__*: Shell style scripts.
- *Modules*: PowerShell defined module directory.
- *Scripts*: PowerShell defined script directory.
