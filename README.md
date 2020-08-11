# vim_cpp

安装一些插件和工具
sudo aptitude install astyle clang-format clang clang-dev dos2unix

1. 代码提示： 安装clang并配置
apt install clang, libclang-dev

2. ycm代码补全
sudo apt-get install clang cmake
cd ~/.vim/bundle/YouCompleteMe
sudo ./install.py --clang-completer --system-libclang

2. 代码格式化: 安装astyle, 并配置vimrc
apt install astyle

3. vim exec :PluginInstall
