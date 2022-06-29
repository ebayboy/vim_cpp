#!/bin/bash

# ***************************************************************************
# * 
# * @file:build.sh 
# * @author:ebayboy@163.com 
# * @date:2019-12-21 15:56 
# * @version 1.0  
# * @description: Shell script 
# * @Copyright (c)  all right reserved 
#* 
#**************************************************************************/ 

#ln -s  .vim .vimrc to root

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

apt install astyle clang-format clang libclang-dev dos2unix cmake

# 1. vim exec :PluginInstall

# 2. ycm代码补全
cd ~/.vim/bundle/YouCompleteMe
git submodule update --init --recursive
sudo ./install.py --clang-completer --system-libclang

[安装YouCompleteMe](https://blog.csdn.net/liao20081228/article/details/80347889)

exit;
