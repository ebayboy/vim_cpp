
set nocompatible
filetype off
set rtp+=$HOME/.vim/bundle/Vundle.vim

call vundle#begin()

Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'tpope/vim-sensible'
Plugin 'flazz/vim-colorschemes'
Plugin 'vim-scripts/taglist.vim'
Plugin 'vim-scripts/OmniCppComplete.git'
Plugin 'tell-k/vim-autopep8'
Plugin 'vim-scripts/cppcomplete'
Plugin 'pangloss/vim-javascript'
Plugin 'chr4/nginx'
Plugin 'mxw/vim-jsx'
Plugin 'moll/vim-node'
Plugin 'vim-scripts/luainspect.vim'
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-lua-ftplugin'

call vundle#end()

execute pathogen#infect()
filetype plugin indent on

syntax enable
syntax on
set hlsearch 

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
map <F5> :make<CR><CR><CR> :copen<CR><CR>

"-- QuickFix setting --
"set temp makefile && make clean
map <F6> <ESC> :w <CR> :set makeprg=g++\ -Wall\ %\ -o%<\ <CR><CR> :make clean<CR><CR>

"next error
map <F7> :cp<CR>
"prev error 
map <F8> :cn<CR>

"imap <F8> <ESC>:cp<CR>
"imap <F9> <ESC>:cn<CR>

nnoremap <silent> <F11> :TlistToggle<CR>
map <F12> :call CreateTags()<CR>

"C/C++ config
autocmd FileType c,cpp,hpp set tags=tags;  " ; 不可省略，表示若当前目录中不存在tags， 则在父目录中寻找。
autocmd FileType c,cpp,hpp set tags+=~/.vim/tags/cpp_src/tags

"python tags
autocmd FileType python set tags+=/root/.virtualenvs/flask_test/tags

set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
set termencoding=utf-8
set encoding=utf-8

let Tlist_Auto_Open=1


"set for react
let g:jsx_ext_required = 0 " Allow JSX in normal JS files
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_javascript_checkers = ['jsxhint']
let g:syntastic_javascript_jsxhint_exec = 'jsx-jshint-wrapper'


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
	if &filetype == 'c' || filetype == 'h'
		exec "!astyle --style=allman --suffix=none %"
	elseif &filetype == 'cpp' || filetype == 'cc' || filetype == 'hpp'
		exec "!astyle --style=allman --suffix=none %"
	elseif &filetype == 'perl'
		exec "!astyle --style=gnu --suffix=none %"
	elseif &filetype == 'py'|| filetype == 'python'
		exec "!autopep8 --in-place --aggressive %"
	elseif &filetype == 'java'
		exec "!astyle --style=java --suffix=none %"
	elseif &filetype == 'jsp'
		exec "!astyle --style=gnu --suffix=none %"
	elseif &filetype == 'xml'
		exec "!astyle --style=gnu --suffix=none %"
	elseif &filetype == 'lua'
		exec "!astyle --style=gnu --suffix=none %"
	else
		exec "normal gg=G"
		return
	endif
endfunc

"============================
"  Python 补全插件设置
"============================
autocmd Filetype python setlocal omnifunc=pythoncomplete#Complete
let g:pydiction_menu_height = 3
let g:pydiction_location = '~/.vim/tools/pydiction/complete-dict'

"============================
"  补全插件设置
"============================
autocmd FileType css,scss set omnifunc=csscomplete#CompleteCSS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript,tsx,js set omnifunc=javascriptcomplete#CompleteJS
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
"  cscope 插件设置
"  :cs f c xx   调用xx的函数
"  :cs f f xx   查找xx文件
"  :cs f e xx   查找所有包含 文件 的位置
"============================
if has("cscope")
	set csprg=/usr/bin/cscope "指定用来执行cscope的命令
	set csto=0 " 设置cstag命令查找次序：0先找cscope数据库再找标签文件；1先找标签文件再找cscope数据库
	set cst " 同时搜索cscope数据库和标签文件
	set cscopequickfix=s-,c-,d-,i-,t-,e- " 使用QuickFix窗口来显示cscope查找结果
	set nocsverb
	if filereadable("cscope.out") " 若当前目录下存在cscope数据库，添加该数据库到vim
		cs add cscope.out
	elseif $CSCOPE_DB != "" " 否则只要环境变量CSCOPE_DB不为空，则添加其指定的数据库到vim
		cs add $CSCOPE_DB
	endif
	set csverb
endif
"查找函数定义
nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR><CR> :copen<CR><CR>
"查找调用这个函数的函数
nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR><CR> :copen<CR><CR>

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
	elseif &filetype == 'lua'
		exec "!time /usr/bin/lua %"
	endif
endfunc

"生成tags文件
func! CreateTags()
	if &filetype == 'c'
		exec "!ctags *.c *.h --c-kinds=+p --fields=+iaS --extra=+fq; cscope -Rbq;"
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
