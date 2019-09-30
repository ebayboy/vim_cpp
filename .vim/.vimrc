
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


map <F4> <ESC> :w <CR> :!git add % && git commit -a -m 'commit %<' && git push <CR> 

map <F5> <ESC> :w <CR> :!g++ -g % -o %< && ./%< <CR>
map <F6> <ESC> :w <CR> :!./%< <CR>
map <F7> <ESC> :w <CR> :!g++ -g % -o %< && valgrind ./%< <CR>

nnoremap <silent> <F8> :TlistToggle<CR>

set tags=tags;  " ; 不可省略，表示若当前目录中不存在tags， 则在父目录中寻找。
map <F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR> "

set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
set termencoding=utf-8
set encoding=utf-8


let g:clang_complete_copen=1
let g:clang_snippets=1
let g:clang_close_preview=1
let g:clang_use_library=1
let g:clang_user_options='-stdlib=libstdc++ -std=c++11 ./'
let g:clang_library_path="/usr/lib/llvm-8/lib"

function AddFileInformation_sh()
	let infor = "#!/bin/bash\n"
				\."\n"
				\."# ***************************************************************************\n"
				\."# * \n"
				\."# * @file:".expand("%")." \n"
				\."# * @author:ebayboy@163.com \n"
				\."# * @date:".strftime("%Y-%m-%d %H:%M")." \n"
				\."# * @version 1.0  \n"
				\."# * @description: Shell script \n"
				\."# * @Copyright (c)  all right reserved \n"
				\."#* \n"
				\."#**************************************************************************/ \n"
				\."\n"
				\."\n"
				\."\n"
				\."\n"
				\."exit 0"
	silent  put! =infor
endfunction
autocmd BufNewFile *.sh call AddFileInformation_sh()


function AddFileInformation_CPP()
	let infor = "/****************************************************************************\n"
				\."@file:".expand("%")." \n"
				\."@author:ebayboy@163.com \n"
				\."@date:".strftime("%Y-%m-%d %H:%M")." \n"
				\."@version 1.0  \n"
				\."@description: cpp file \n"
				\."@Copyright (c)  all right reserved \n"
				\."**************************************************************************/\n\n"
				\."#include <iostream>\n\n"   
				\."using namespace std;\n\n"
				\."int main(int argc, char **argv)\n"
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

