# Powershell rice configuration
## Get started
```powershell
PS> . .\poshrc.ps1
```

## Modules
### core.psm1
#### Module loader
```powershell
RiceModule [options] <rice module>
Options:
    -List       : List all available rice modules
    -Load       : Load a rice module
    -Unload     : Unload a rice module
```

### stylers.psm1
#### Prompt styler
Write a custom prompt module with exported function `PSPrompt` and place it into `styles\prompts\`.
```powershell
RicePrompt [options] <prompt module>
Options:
    -List       : List all available prompt modules
    -Save       : Save current prompt style
    -Restore    : Restore saved prompt style
    -Default    : Restore default prompt style
```

#### Theme styler
Place *ColorTool* compatible themes into `styles\schemes\` and *PSReadLine* color config files (optional) with the same name into `styles\pscolors`.
```powershell
RiceTheme [options] <color theme>
Options:
    -List       : List all available color themes
    -Save       : Save current color theme
    -Restore    : Restore saved color theme
    -Default    : Restore default color theme
```
*PSReadLine* config files are in json format accepting literal string or escape sequence for values.
```json
{
    "Command":  "\u001b[93m",
    "Comment":  "\u001b[32m",
    "ContinuationPrompt":  "\u001b[37m",
    "Default":  "\u001b[37m",
    "Emphasis":  "\u001b[96m",
    "Error":  "\u001b[91m",
    "Keyword":  "\u001b[92m",
    "Member":  "\u001b[97m",
    "Number":  "\u001b[97m",
    "Operator":  "\u001b[90m",
    "Parameter":  "\u001b[90m",
    "Selection":  "\u001b[30;47m",
    "String":  "\u001b[36m",
    "Type":  "\u001b[37m",
    "Variable":  "\u001b[92m"
}
```

#### Color tool
[ColorTool](https://github.com/microsoft/terminal/tree/master/src/tools/ColorTool) wrapper.
```powershell
ColorTool [options] <schemename>
Arguments:
    <schemename>: The name of a color scheme. ct will try to first load it as an .itermcolors color scheme.
                  If that fails, it will look for it as an .ini file color scheme.
Options:
    -?, --help     : Display this help message
    -c, --current  : Print the color table for the currently applied scheme
    -q, --quiet    : Don't print the color table after applying
    -d, --defaults : Apply the scheme to only the defaults in the registry
    -b, --both     : Apply the scheme to both the current console and the defaults.
    -s, --schemes  : Display all available schemes
    -v, --version  : Display the version number
```

### shim.psm1
#### Shim installer
All app shim manifest are in json format placed into `packages\` directory.
```powershell
RiceShim [options] <app>
Options:
    -List       : List all available app
    -Install    : Install specified app. Can use space to separate several apps at a time
        -All    : Install all apps specified under packages directory
```
App shim manifest template. You can specify multiple binary shortcut in a package manifest. `name` and `exec` are mandatory. If executable is a script, you should specify interpreter.
```json
{
    "dir": "package_dir_name",
    "bin": [
        {
            "name": "shortcut_name",
            "exec": "binary_path",
            "interpreterargs": "arguments",
            "interpreter": "interpreter_path"
        }
    ],
    "env": [
        "environment_path"
    ],
    "post": [
        "post installation command"
    ]
}
```

### commands.psm1
Linux style commands

## Credits
Shim is inspired by [Scoop](https://github.com/lukesampson/scoop)
