Get configuration file location for different scope
- *AllUsersAllHosts*: `$PROFILE.AllUsersAllHosts`
- *AllUsersCurrentHost*: `$PROFILE.AllUsersCurrentHost`
- *CurrentUserAllHosts*: `$PROFILE.CurrentUserAllHosts`
- *CurrentUserCurrentHost*: `$PROFILE.CurrentUserCurrentHost`

Rename `init-template.ps1` to `init.ps1` and then source it.

Make your own changes in the `init.ps1` file.

```
. path/to/init.ps1
```
