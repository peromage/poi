# Rice Vim Configuration

## Prerequisites

- NodeJs (`node` and `npm` must in path)
- Python3 (`pynvim` installed)

## Usage

- Copy all contents in this folder to your local nvim/vim config directory.

    Example for NeoVim

    - Linux: ~/.config/nvim
    - Windows: %APPDATA%\Local\nvim

- Rename `init-template.vim` to `init.vim` or `.vimrc`. All customizations should go in here.

- Uncomment variables starts with `RC_*` to enable functionalities.

- Uncomment `g:python3_host_prog` and set Python path.

- Enjoy

## Directories

- *\_\_rc\_\_*: This configuration core files.
- *autoload*: Vim autoload directory.
- *colors*: Vim color scheme directory.
