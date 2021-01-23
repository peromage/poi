# Rice NeoVim Configuration

Configurations are based on NeoVim. It might be compatible with Vim.

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
- *ondemand*: Manually loaded plugins.
