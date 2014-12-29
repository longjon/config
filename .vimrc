au!

" LaTeX-suite settings
filetype plugin on
filetype plugin indent on

set grepprg=grep\ -nH\ $*

let g:tex_flavor='latex'

set t_Co=256
syntax on
"set background=dark
colorscheme elflord
hi Search ctermbg=cyan
hi IncSearch ctermfg=darkgrey

set showcmd
set cul
set autoindent
set tabstop=4
set expandtab
set shiftwidth=4
set softtabstop=4
set incsearch
set hlsearch

set nojoinspaces

set wildmode=longest,list,full
set wildmenu
set mouse=a

set cc=80

au FileType python setl autoindent tabstop=4 expandtab shiftwidth=4 softtabstop=4
au FileType c setl autoindent tabstop=2 expandtab shiftwidth=2 softtabstop=2
au FileType cuda setl autoindent tabstop=2 expandtab shiftwidth=2 softtabstop=2
au FileType cpp setl autoindent tabstop=2 expandtab shiftwidth=2 softtabstop=2
au FileType javascript setl autoindent tabstop=2 expandtab shiftwidth=2 softtabstop=2
au InsertLeave * update
au CursorMoved * exe printf('match IncSearch /\V\<%s\>/', escape(expand('<cword>'), '/\'))

nmap <Space> i<Space><Esc>r

set backspace=indent,eol,start

" sticky shift
com! W w
