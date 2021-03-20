# Peromage's (Neo)Vim Configuration And Other Stuff

👻👾🤖🐱‍👤🐱‍🏍🐱‍💻🐱‍🐉🐱‍👓🐱‍🚀😺

Essential needs like rice.

The root of this repo is used as (Neo)Vim runtime path as well as for other tool's entry.

## Dependencies

Essential

- Latest [Python][python_url]: `pynvim` installed and with `python` in `PATH` (Required by Vim `Leaderf`)
- Latest [Node.js][nodejs_url]: with `node` and `npm` in `PATH` (Required by Vim `Coc.nvim`)

Recommended

- [Lua][lua_url]
- [DejaVu Sans Mono For Powerline][dejavu sans mono for powerline url]
- [Cascadia Code][cascadia code url]
- [universal-ctags][ctags_url]

## Get Started

1. Add init files in your rc config file

(Neo)Vim

```viml
" In ~/.vimrc or ~/.config/nvim/init.vim
source /path/to/init.vim

" In ~/.gvimrc or ~/.config/nvim/ginit.vim
source /path/to/ginit.vim
```

PowerShell

```powershell
# In $PROFILE.CurrentUserAllHosts
. /path/to/init.ps1
```

Bash

```bash
# In ~/.bashrc
. /path/to/init.sh
```

2. Read comments in the init files, set configuration variables.

3. For the first time startup, run `:PlugInstall` to get plugins installed.

4. This configuration is also compatible with [VSCode NeoVim plugin][vscode-neovim]. Check `init.vim` for details.

5. Enjoy

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

## Credits

This bundle uses following awesome projects. Thank them all for the great contributions.

- [lf][lf_url]
- [fzf][fzf_url]
- [ripgrep][ripgrep_url]
- [bat][bat_url]
- [z.lua][zlua_url]


[python_url]: https://www.python.org/downloads/
[nodejs_url]:https://nodejs.org/en/download/current/

[lua_url]: http://luabinaries.sourceforge.net/download.html
[dejavu sans mono for powerline url]: https://github.com/powerline/fonts
[cascadia code url]: https://github.com/microsoft/cascadia-code
[ctags_url]: https://github.com/universal-ctags/ctags!

[lf_url]: https://github.com/gokcehan/lf
[fzf_url]: https://github.com/junegunn/fzf
[ripgrep_url]: https://github.com/BurntSushi/ripgrep
[bat_url]: https://github.com/sharkdp/bat
[zlua_url]: https://github.com/skywind3000/z.lua
[vscode-neovim]: https://github.com/asvetliakov/vscode-neovim
