# Peromage's (Neo)Vim Configuration And Other Stuff

👻👾🤖🐱‍👤🐱‍🏍🐱‍💻🐱‍🐉🐱‍👓🐱‍🚀😺

Essential needs like rice.

The root of this repo is used as (Neo)Vim runtime path as well as for other tool's entry.

## Dependencies

Essential

- Latest [Python][python]: `pynvim` installed and with `python` in `PATH` (Required by Vim `Leaderf`)
- Latest [Node.js][nodejs]: with `node` and `npm` in `PATH` (Required by Vim `Coc.nvim`)

Optional

- [lf][lf]
- [fzf][fzf_url]
- [ripgrep][ripgrep_url]
- [universal-ctags][ctags_url]
- [bat][bat_url]

Optional fonts
- [DejaVu Sans Mono For Powerline][dejavu sans mono for powerline]
- [Cascadia Code][cascadia code]

## Get Started

1. Remove "template" prefix for the files `template-*` and then source this file from your main rc file.

```viml
" In ~/.vimrc or ~/.config/nvim/init.vim
source /path/to/init.vim
```

```powershell
# In $PROFILE.CurrentUserAllHosts
. /path/to/init.ps1
```

```bash
# In ~/.bashrc
. /path/to/init.sh
```

2. Uncomment and modify configuration variables to enable features.

3. Enjoy

## Directories

Directories which start with "@" contain configurations for other applications and stuff that is not used often. Doing it in this way to avoid naming conflicts.

- *@archive*: Old files.
- *@docs*: Some notes.
- *appconfig*: Configurations for daily used applications.
- *rice_pwsh*: Rice PowerShell module.
- *rice_bash*: Rice Bash module.
- *autoload*: Vim common libraries.
- *colors*: Vim color schemes.
- *plugin*: Vim additional plugins (Loaded all the time).
- *plugin_disabled*: Vim additional plugins that are disabled.
- *rice_pwsh/base*: Essential scripts. Required on all platforms.
- *rice_pwsh/base_win*: Windows related scripts.
- *rice_pwsh/features*: Additional features for advanced usage.
- *rice_pwsh/themes*: CLI themes
- *rice_pwsh/src*: Source code written other than PowerShell scripts, DotNet usually.
- *rice_pwsh/scripts*: This directory will be added to PATH so any PowerShell script can be dropped in and invoked at any time.
- *rice_bash/base*: Essential scripts
- *rice_bash/features*: Scripts modules for advanced usage.
- *rice_bash/themes*: CLI prompt themes.
- *rice_bash/scripts*: A drop-in directory which will be added to PATH.


[lf]: https://github.com/gokcehan/lf
[fzf_url]: https://github.com/junegunn/fzf
[ripgrep_url]: https://github.com/BurntSushi/ripgrep
[ctags_url]: https://github.com/universal-ctags/ctags!
[bat_url]: https://github.com/sharkdp/bat
[python]: https://www.python.org/downloads/
[nodejs]:https://nodejs.org/en/download/current/
[dejavu sans mono for powerline]: https://github.com/powerline/fonts
[cascadia code]: https://github.com/microsoft/cascadia-code
