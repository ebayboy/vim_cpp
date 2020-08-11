
set nocompatible
filetype off
set rtp+=$HOME/.vim/bundle/Vundle.vim

call vundle#begin()

Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'tpope/vim-sensible'
Plugin 'vim-scripts/taglist.vim'

call vundle#end()

execute pathogen#infect()
filetype plugin indent on
syntax on

set runtimepath+=~/.vim/bundle/YouCompleteMe
let g:ycm_collect_identifiers_from_tags_files = 1 " 开启 YCM 基于标签引擎
let g:ycm_collect_identifiers_from_comments_and_strings = 1 " 注释与字符串中的内容也用于补全
let g:syntastic_ignore_files=[".*.py$"]
let g:ycm_seed_identifiers_with_syntax = 1 " 语法关键字补全
let g:ycm_complete_in_comments = 1
let g:ycm_confirm_extra_conf = 0
let g:ycm_key_list_select_completion = ['<c-n>', '<Down>'] " 映射按键, 没有这个会拦截掉tab, 导致其他插件的tab不能用.
let g:ycm_key_list_previous_completion = ['<c-p>', '<Up>']
let g:ycm_complete_in_comments = 1 " 在注释输入中也能补全
let g:ycm_complete_in_strings = 1 " 在字符串输入中也能补全
let g:ycm_collect_identifiers_from_comments_and_strings = 1 " 注释和字符串中的文字也会被收入补全
let g:ycm_global_ycm_extra_conf='~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
let g:ycm_show_diagnostics_ui = 0 " 禁用语法检查
inoremap <expr> <CR> pumvisible() ? "<C-y>" : "<CR>" | " 回车即选中当前项
nnoremap <c-j> :YcmCompleter GoToDefinitionElseDeclaration<CR>| " 跳转到定义处
let g:ycm_min_num_of_chars_for_completion=2 " 从第2个键入字符就开始罗列匹配项

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

"format 
map <F2> :call FormatCode()<CR>
"git push
map <F3> <ESC> :w <CR> :!git add % && git commit -a -m 'commit %<' && git push <CR> 
"g++ && run
map <F4> <ESC> :w <CR> :!g++ -std=c++11 -Wall -g % -o %< && ./%< <CR>
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

let g:clang_complete_copen=1
let g:clang_snippets=1
let g:clang_close_preview=1
let g:clang_use_library=1
let g:clang_user_options='-stdlib=libstdc++ -std=c++11 ./'
let g:clang_library_path="/usr/lib/llvm-10/lib"
"F2 format code auto, please install astyle first."
let g:formatdef_allman = '"astyle --style=allman --pad-oper"'
let g:formatters_cpp = ['allman']
let g:formatters_c = ['allman']

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


