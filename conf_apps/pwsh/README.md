# Rice PowerShell Configuration

## Usage

Rename `init-template.ps1` to `init.ps1` and then source it.

Make your own changes in the `init.ps1` file.

```powershell
$ . path/to/init.ps1
```

## Configuration Locations

Get configuration file location for different scopes.

- *AllUsersAllHosts*: `$PROFILE.AllUsersAllHosts`
- *AllUsersCurrentHost*: `$PROFILE.AllUsersCurrentHost`
- *CurrentUserAllHosts*: `$PROFILE.CurrentUserAllHosts`
- *CurrentUserCurrentHost*: `$PROFILE.CurrentUserCurrentHost`

## Directories

- *__rc__*: Directory that contains all configurations.
- *__rc__/autoload.d*: Dropdown menu. Modules in this directory are autoloaded.
- *__rc__/themes*: Command line themes.
- *__rc__/modules*: Modules that can be loaded on demands.
- *__rc__/srcs*: Source code in C# or other languages.
