
set nocompatible
filetype off
set rtp+=$HOME/.vim/bundle/Vundle.vim

call vundle#begin()

Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'tpope/vim-sensible'

call vundle#end()

execute pathogen#infect()
filetype plugin indent on
syntax on

set nu
set tabstop=4
set shiftwidth=4
set softtabstop=4
set autochdir
set mouse=a
set autoindent
set smartindent
set cindent
inoremap ( ()<ESC>i
inoremap [ []<ESC>i
inoremap " ""<ESC>i
inoremap ' ''<ESC>i
inoremap { {<CR>}<ESC>kA<CR>


map <F5> <ESC> :w <CR> :!g++ -g % -o %< && ./%< <CR>
map <F6> <ESC> :w <CR> :!g++ -g % -o %< && valgrind ./%< <CR>

nnoremap <silent> <F8> :TlistToggle<CR>

set tags=tags;  " ; 不可省略，表示若当前目录中不存在tags， 则在父目录中寻找。
map <F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR> "

set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
set termencoding=utf-8
set encoding=utf-8


