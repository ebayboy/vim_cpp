#!/bin/bash

# ***************************************************************************
# * 
# * @file:build_cpp_tags.sh 
# * @author:ebayboy@163.com 
# * @date:2019-11-18 18:54 
# * @version 1.0  
# * @description: Shell script 
# * @Copyright (c)  all right reserved 
#* 
#**************************************************************************/ 

#:PluginInstall


ln -s $PWD/.vim /root/
ln -s $PWD/.vim/.vimrc /root/
ln -s $PWD/.vim/.cpp_stl_tags /root/

#tar xf cpp_src.tar.gz
#ctags -R --c++-kinds=+p --fields=+iaS --extra=+q --language-force=C++ cpp_src

exit 0
