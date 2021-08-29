""" gui-init-keybindings.vim -- GUI key bindings

let g:loaded_poi_gui_init_keybindings = 1

vmap <C-S-c> <Plug>(poi_clipboard_copy)
vmap <C-S-v> <Plug>(poi_clipboard_paste)

imap <C-S-c> <Plug>(poi_clipboard_copy)
imap <C-S-v> <Plug>(poi_clipboard_paste)
