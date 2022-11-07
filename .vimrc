call plug#begin('~/.vim/plugged')
Plug 'arcticicestudio/nord-vim'
Plug 'dracula/vim', {'as':'dracula'}
Plug 'chriskempson/tomorrow-theme/'
Plug 'morhetz/gruvbox'
Plug 'fladson/vim-kitty'
call plug#end()

let &t_ut=''
syntax enable
set number
set relativenumber
set background=dark
set tabstop=4
set shiftwidth=4
set expandtab
set showcmd
set autoindent
set laststatus=2
set termguicolors
colorscheme dire
