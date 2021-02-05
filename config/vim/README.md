# Rice NeoVim Configuration

This configuration is compatible with Vim and NeoVim.

## Prerequisites

- NodeJs (`node` and `npm` must in path, required by Coc.nvim)
- Python3 (`pynvim` installed, required by LeaderF)

## Usage

- Copy all contents in this folder to your local nvim/vim config directory.

    Example for NeoVim

    - Linux: ~/.config/nvim
    - Windows: %APPDATA%\Local\nvim

- Rename `template_init.vim` to `init.vim` or `.vimrc`. All customizations should go in there.

- Make sure this directory is in `runtimepath`.

- Uncomment and modify configuration variables to enable features.

- Enjoy

## Directories

- *autoload*: Common libraries.
- *colors*: Color schemes.
- *plugin*: Additional plugins (Loaded all the time).

## Some Other Tools That Might Need To Be Installed

- [fzf][fzf_url]
- [ripgrep][ripgrep_url]
- [universal-ctags][ctags_url]
- [bat][bat_url]

[fzf_url]: https://github.com/junegunn/fzf
[ripgrep_url]: https://github.com/BurntSushi/ripgrep
[ctags_url]: https://github.com/universal-ctags/ctags!
[bat_url]: https://github.com/sharkdp/bat
