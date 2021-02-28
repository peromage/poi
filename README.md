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

- *notes*: Some notes.
- *appconfig*: Configurations for daily used applications.
- *ripwsh*: Rice PowerShell module.
- *ribash*: Rice Bash module.
- *autoload*: Vim common libraries.
- *colors*: Vim color schemes.
- *plugin*: Vim additional plugins (Loaded all the time).
- *plugin_inactive*: Vim additional plugins that are disabled.
- *setup*: Rice Vim configurations.
- *bin*: Scripts and executables.

[lf]: https://github.com/gokcehan/lf
[fzf_url]: https://github.com/junegunn/fzf
[ripgrep_url]: https://github.com/BurntSushi/ripgrep
[ctags_url]: https://github.com/universal-ctags/ctags!
[bat_url]: https://github.com/sharkdp/bat
[python]: https://www.python.org/downloads/
[nodejs]:https://nodejs.org/en/download/current/
[dejavu sans mono for powerline]: https://github.com/powerline/fonts
[cascadia code]: https://github.com/microsoft/cascadia-code
