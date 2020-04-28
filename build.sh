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


yum install ctags -y

tar xvf .vim/vendors/astyle_3.1_linux.tar.gz  -C .vim/vendors/

cd .vim/vendors/astyle/build
cmake ../ && make && make install
cd -

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

exit;
