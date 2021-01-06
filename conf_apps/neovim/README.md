# Rice NeoVim Configuration

Mainly configured for NeoVim. It should be compatible with Vim (maybe).

## Prerequisites

- NodeJs (`node` and `npm` must in path)
- Python3 (`pynvim` installed)

## Usage

- Copy all contents in this folder to your local nvim/vim config directory.

    Example for NeoVim

    - Linux: ~/.config/nvim
    - Windows: %APPDATA%\Local\nvim

- Rename `template_init.vim` to `init.vim` or `.vimrc`. All customizations should go in here.

- Uncomment variables starts with `RC_*` to enable functionalities.

- Uncomment `g:python3_host_prog` and set Python path.

- Enjoy

## Directories

- *\_\_rc\_\_*: This configuration core files.
- *\_\_rc\_\_/autoload.d*: Dropdown directory. Modules in this directory will be autoloaded.
- *\_\_rc\_\_/modules*: Modules that can be loaded on demands.
- *\_\_rc\_\_/plugins*: Pre-configured plugins (need vim-plug to install).
- *autoload*: NeoVim autoload directory.
- *colors*: NeoVim color scheme directory.
