
set nocompatible
filetype off
set rtp+=$HOME/.vim/bundle/Vundle.vim

call vundle#begin()

Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'tpope/vim-sensible'
Plugin 'flazz/vim-colorschemes'
Plugin 'vim-scripts/taglist.vim'
Plugin 'vim-scripts/OmniCppComplete.git'

call vundle#end()

execute pathogen#infect()
filetype plugin indent on

syntax enable
syntax on

"colorscheme molokai
"autocmd FileType sh,ksh,csh colorscheme solarized
"autocmd FileType python colorscheme onedark
"autocmd FileType *.html,*.htm colorscheme delek

set nu
set ruler
set wildmenu 
set showcmd 
set tabstop=4
set shiftwidth=4
set softtabstop=4
set autochdir
set mouse=a
set autoindent
set smartindent
set cindent

"F2 format code auto, please install astyle first."
let g:formatdef_allman = '"astyle --style=allman --pad-oper"'
map <F2> :call FormatCode()<CR>

inoremap ( ()<ESC>i
inoremap [ []<ESC>i
inoremap " ""<ESC>i
inoremap ' ''<ESC>i
inoremap { {<CR>}<ESC>kA<CR>

"GIT setting 
map <F3> <ESC> :w <CR> :!git add % && git commit -a -m 'commit %<' && git push <CR> 
map <F4> :call ComplieAndRun() <CR>

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

map <F12> :call CreateTags()<CR>

nnoremap <silent> <F11> :TlistToggle<CR>

"C/C++ config
autocmd FileType c,cpp,hpp set tags=tags;  " ; 不可省略，表示若当前目录中不存在tags， 则在父目录中寻找。
autocmd FileType c,cpp,hpp set tags+=~/.vim/tags/cpp_src/tags


set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
set termencoding=utf-8
set encoding=utf-8

let Tlist_Auto_Open=1

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
				\."@version: 1.0  \n"
				\."@description: cpp file \n"
				\."@Copyright (c)  all right reserved \n"
				\."**************************************************************************/\n\n"
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
autocmd BufNewFile *.hpp call AddFileInformation_CPP()

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

function AddFileInformation_py()
	let infor = "#!/usr/bin/python3\n\n"
				\."#/****************************************************************************\n"
				\."#@file:".expand("%")." \n"
				\."#@author:ebayboy@163.com \n"
				\."#@date:".strftime("%Y-%m-%d %H:%M")." \n"
				\."#@version 1.0  \n"
				\."#@description: python file \n"
				\."#@Copyright (c)  all right reserved \n"
				\."#**************************************************************************/\n\n"
	silent  put! =infor
endfunction
autocmd BufNewFile *.py call AddFileInformation_py()


func! FormatCode()
    exec "w"
    if &filetype == 'c' || &filetype == 'h'
        exec "!astyle --style=allman --suffix=none %"
    elseif &filetype == 'cpp' || &filetype == 'cc' || &filetype == 'hpp'
        exec "!astyle --style=allman --suffix=none %"
    elseif &filetype == 'perl'
        exec "!astyle --style=gnu --suffix=none %"
    elseif &filetype == 'py'|| &filetype == 'python'
        exec "!autopep8 --in-place --aggressive %"
    elseif &filetype == 'java'
        exec "!astyle --style=java --suffix=none %"
    elseif &filetype == 'jsp'
        exec "!astyle --style=gnu --suffix=none %"
    elseif &filetype == 'xml'
        exec "!astyle --style=gnu --suffix=none %"
    else
        exec "normal gg=G"
        return
    endif
endfunc

"============================
"  补全插件设置
"============================
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType ruby set omnifunc=rubycomplete#Complete
autocmd FileType perl set omnifunc=perlcomplete#Complete

"============================
"  C++ 补全插件设置
"============================
autocmd Filetype c setlocal omnifunc=cppcomplete#Complete
autocmd Filetype cpp setlocal omnifunc=cppcomplete#Complete
" search namespaces in the current buffer   and in included files
let OmniCpp_NamespaceSearch = 2     
let OmniCpp_ShowPrototypeInAbbr = 1 " 显示函数参数列表
let OmniCpp_MayCompleteScope = 1    " 输入 :: 后自动补全
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
let OmniCpp_DisplayMode = 1 		"always show all members

"============================
"  Python 补全插件设置
"============================
autocmd Filetype python setlocal omnifunc=pythoncomplete#Complete
let g:pydiction_location='~/.vim/tools/pydiction/complete-dict'


"============================
"  函数定义
"============================
"编译
func! ComplieAndRun()
	exec "w"
	if &filetype == 'c'
        exec "!g++ % -o %<"
        exec "!time ./%<"
    elseif &filetype == 'cpp'
        exec "!g++ % -std=c++11 -o %<"
        exec "!time ./%<"
    elseif &filetype == 'java' 
        exec "!javac %" 
        exec "!time java %<"
    elseif &filetype == 'sh'
        :!time bash %
    elseif &filetype == 'python'
        exec "!time python3 %"
    elseif &filetype == 'html'
        exec "!google-chrome % &"
    endif
endfunc

"生成tags文件
func! CreateTags()
	if &filetype == 'c'
		exec "!ctags *.c *.h --c-kinds=+p --fields=+iaS --extra=+fq "
	elseif &filetype == 'cpp'
		exec "!ctags *.cpp *.h *.hpp *.c --c++-kinds=+px --fields=+iaS --extra=+fq "
	elseif &filetype == 'java'
		exec "!ctags *.java --java-kinds=+p --fields=+iaS --extra=+fq "
	elseif &filetype == 'python'
		exec "!ctags *.py --python-kinds --fields=+iaS --extra=+f "
	elseif &filetype == 'html'
		exec "!ctags *.html --html-kinds=+p --fields=+iaS --extra=+f "
	endif
endfunc
