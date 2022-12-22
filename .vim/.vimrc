
set nocompatible
filetype off
set rtp+=$HOME/.vim/bundle/Vundle.vim

call vundle#begin()

Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'tpope/vim-sensible'
Plugin 'vim-scripts/taglist.vim'
Plugin 'tpope/vim-pathogen'
Plugin 'Valloric/YouCompleteMe'
Plugin 'honza/vim-snippets'
Plugin 'SirVer/ultisnips'
Plugin 'ervandew/supertab'
Plugin 'rhysd/vim-clang-format'

call vundle#end()

execute pathogen#infect()

filetype plugin indent on
syntax on

set nu

"set shiftwidth=4
"set tabstop=4
"set softtabstop=4
set autochdir
set cindent
set mouse=v
set autoindent
set smartindent

""inoremap ( ()<ESC>i
""inoremap [ []<ESC>i
""inoremap " ""<ESC>i
""inoremap ' ''<ESC>i
""inoremap { {<CR>}<ESC>kA<CR>

"git push
map <F3> <ESC> :w <CR> :!git add % && git commit -a -m 'commit %<' && git push <CR> 
"g++ && run
map <F4> <ESC> :w <CR> :!g++ -std=c++20 -Wall -g % -o %< && ./%< <CR>
"run
map <F5> <ESC> :w <CR> :!./%< <CR>

"-- QuickFix setting --
"set temp makefile && make clean
map <F6> <ESC> :w <CR> :set makeprg=g++\ -Wall\ %\ -o%<\ <CR><CR> :make clean<CR><CR>
"make
map <F7> :make<CR><CR><CR> :copen<CR><CR>
"next error
map <F8> :cp<CR>
"prev error 
map <F9> :cn<CR>
imap <F6> <ESC>:make clean<CR><CR><CR>
imap <F7> <ESC>:make<CR><CR><CR> :copen<CR><CR>
imap <F8> <ESC>:cp<CR>
imap <F9> <ESC>:cn<CR>

nnoremap <silent> <F11> :TlistToggle<CR>
set tags=tags;  " ; 不可省略，表示若当前目录中不存在tags， 则在父目录中寻找。
map <F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR> "

set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
set termencoding=utf-8
set encoding=utf-8

" snip expand
" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

" better key bindings for UltiSnipsExpandTrigger(using with supertab)
let g:UltiSnipsExpandTrigger="<c-e>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

" F2 format with clang-format
let g:clang_format#command = 'clang-format'
nmap <F2> :ClangFormat<CR>
""au BufWrite * :ClangFormat
autocmd FileType c ClangFormatAutoEnable
let g:clang_format#detect_style_file = 1
let g:clang_complete_copen=1
let g:clang_snippets=1
let g:clang_close_preview=1
let g:clang_use_library=1
let g:clang_user_options='-stdlib=libstdc++ -std=c++20 ./'
""let g:clang_library_path="/usr/lib/llvm-10/lib"

function AddFileInformation_CPP()
	let infor = "/****************************************************************************\n"
				\."#include <iostream>\n"   
				\."#include <string>\n"   
				\."#include <numeric>\n"   
				\."#include <vector>\n"   
				\."#include <algorithm>\n"   
				\."\nusing namespace std;\n"
				\."\n#define DEBUG \n"
				\."\nint main(int argc, char **argv)\n"
				\."{\n\n"
				\."	cout<<\"hello world!\"<<endl;\n\n"
				\."	return 0;\n"
				\."}"
	silent  put! =infor
endfunction
autocmd BufNewFile *.cpp call AddFileInformation_CPP()

function AddFileInformation_C()
	let infor = "/****************************************************************************\n"
				\."@file:".expand("%")." \n"
				\."@author:ebayboy@163.com \n"
				\."@date:".strftime("%Y-%m-%d %H:%M")." \n"
				\."@version 1.0  \n"
				\."@description: cpp file \n"
				\."@Copyright (c)  all right reserved \n"
				\."**************************************************************************/\n\n"
				\."#include <stdio.h>\n\n"   
				\."#include <unistd.h>\n\n"   
				\."int main(int argc, char **argv)\n"
				\."{\n\n"
				\."	printf(\"hello world!\\n\");\n\n"
				\."	return 0;\n"
				\."}"
	silent  put! =infor
endfunction
autocmd BufNewFile *.c call AddFileInformation_C()

