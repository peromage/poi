# Rice PowerShell Configuration

## Usage

Rename `template_init.ps1` to `init.ps1` and then source it.

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

- *\_\_rc\_\_*: Directory that contains all configurations.
- *\_\_rc\_\_/autoload.d*: Dropdown menu. Modules in this directory are autoloaded.
- *\_\_rc\_\_/themes*: Command line themes.
- *\_\_rc\_\_/modules*: Modules that can be loaded on demands.
- *\_\_rc\_\_/srcs*: Source code in C# or other languages.
