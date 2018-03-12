syntax on

" Load plugins with vim-plug
call plug#begin('~/.local/share/nvim/plugged')
    "Plug 'Valloric/YouCompleteMe'  "Needs Python update or something
    Plug 'scrooloose/nerdtree'
    Plug 'davidoc/taskpaper.vim'
call plug#end()

" Keyboard Mappings
    " Show/hide nerdtree
    map <C-n> :NERDTreeToggle<CR>

" File type settings
    " Java
    au FileType java set expandtab ts=4 sw=4 ai             "tab = 4 spaces
    au FileType java set number                             "Show numbers
    au BufNewFile *.java 0r ~/Dropbox/Templates/skel.java   "Template

    " Markdown
    au FileType markdown,md set expandtab ts=2 sw=2 ai      "tab = 2 spaces
    au FileType markdown,md silent set linebreak breakat    "break lines at whitespace
    au FileType markdown,md set linebreak breakindent       "Indent same amount after break

    " Shell scripts
    au FileType sh set expandtab ts=4 sw=4 ai               "tab = 2 spaces
    au FileType sh set number                               "Show numbers

    " Taskpaper
    au FileType taskpaper silent set linebreak breakat      "break lines at whitespace
    au FileType taskpaper set linebreak breakindent         "Indent same amount after break

    " Vim configs
    au FileType vim set expandtab ts=4 sw=4 ai              "tab = 2 spaces
    au FileType vim set number                              "Show numbers

" File path settings
    " Notes
    "au BufRead,BufNewFile $HOME/Dropbox/Notes/* NERDTree
