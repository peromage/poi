# POI - Peromage's neOvim confIguration

> This is also compatible with Vim poi~

> As of 08/28/2021 I have switched to Emacs so I will not update this rpeo frequently.

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

There are two ways to use this configuration.

Put the following content in the Neovim/Vim's RC file.

```vim
" Neovim: ~/.config/nvim/init.vim
" Vim: ~/.vimrc
source poi/init.vim

" Neovim: ~/.config/nvim/ginit.vim
" Vim: ~/.gvimrc
source poi/ginit.vim
```

Or for Neovim, you can simply clone this repo to the location where Neovim reads its configuration.

```bash
# Linux
git clone https://github.com/peromage/poi.git ~/.config/nvim

# Windows
git clone https://github.com/peromage/poi.git ~/AppData/Local/nvim
```

For the first time startup, run `:PlugInstall` to install plugins.

Notes:

- Read comments in the init files, set configuration variables.
- This configuration is also compatible with [VSCode NeoVim plugin][vscode-neovim]. Check `init.vim` for details.

Enjoy.

## Local Files

Any local changes can go into `poi/local.vim` and `poi/local-gui.vim`. Local changes will be applied on top of the default poi configuration.

## Directories

- *viml*: Poi Vim configurations.
- *autoload*: Vim common libraries.
- *colors*: Vim color schemes.
- *plugin*: Vim additional plugins (Loaded all the time).
- *bin*: Scripts and executables.

## Credits

This bundle uses following awesome projects. Thank them all for the great contributions.

- [lf][lf_url]
- [fzf][fzf_url]
- [ripgrep][ripgrep_url]
- [bat][bat_url]


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
[vscode-neovim]: https://github.com/asvetliakov/vscode-neovim

## TODO:

- [ ] Move to Vim native LSP support
- [ ] Rewrite with Lua
