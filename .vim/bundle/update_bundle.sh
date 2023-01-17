#!/bin/bash

# ***************************************************************************
# * 
# * @file:update_bundle.sh 
# * @author:ebayboy@163.com 
# * @date:2022-12-16 14:32 
# * @version 1.0  
# * @description: Shell script 
# * @Copyright (c)  all right reserved 
#* 
#**************************************************************************/ 

array=("supertab"  "taglist.vim"  "ultisnips"  "vim-clang-format"  "vim-cpp-enhanced-highlight"  "vim-pathogen"  "vim-sensible"  "vim-snippets"  "Vundle.vim"  "YouCompleteMe")

for((i=0;i<${#array[@]};i++))
do
	plugin="${array[$i]}"
	echo "updating $plugin ..."
	cd $plugin
	git pull
	cd ..
done

exit 0

