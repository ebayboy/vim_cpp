# vim_cpp

首先主要是看上面那两篇 blog, 已经很全了,需要再安装 clang ,为了保证全部覆盖,可以先 search clang,然后将能装的都装上.一般来说,装 clang, clang-dev, 就足够了,虽然我也不知道都是干什么的.....然后就是下载vim的clang 插件.这个在 这里.当然推荐用git 这个工具下载. 如下:


git clone https://github.com/Rip-Rip/clang_complete.git
cd clang_complete
make
vim clang_complete.vmb -c 'so %' -c 'q'
这样,你的 vim  clang_complete 插件应该装好了. 下面是配置了.不多说了,直接写对应的配置文件.其实都是我从别人 blog 中看来的,但是我想说的是,如果你做完了上面的所有步骤后,打开vim,编辑 cpp 文件,当输入 :: -> . 发现没有出现提示的话,那说明你没有配置好. 很可能的一个问题就是你的clang_library_path 部队. 你可以找一下你的 libclang在什么地方. 我的是 /usr/lib 下面.把这个路径换成你的路径,应该就可以了. 

let g:clang_complete_copen=1
let g:clang_snippets=1
let g:clang_close_preview=1
let g:clang_use_library=1
let g:clang_user_options='-stdlib=libstdc++ -std=c++11 IncludePath'
let g:clang_library_path="/usr/lib/"
$: whereis libclang
$: libclang: /usr/lib/libclang.so /usr/lib/libclang.a
好了,上面应该足够了,反正我就是这样配置好的.最后,上一张截图表示一下心意, Good luck .





后记：

过了两天，我的系统重装了有，然后我照上面的方法安装 补全功能，发现又失败了。问题出来 找不到 libclang.a 这个东西。但是我明明安装了 libclang-dev clang 的。那应该就是路径不对，我需要知道 libclang.a 这个东西的具体路径。我知道它一定是在 libclang-dev 中的，也就是说在安装 libclang-dev 的过程中一定安装了，它现在是存在的，就是路径不对。所以只要知道 libclang-dev 安装在哪里了就可以了。怎么办呢，这样的需求。这时候就可以用dpkg 啦。ubuntu 软件包管理 。我用了

 sudo dpkg -L libclang-dev
 然后看到了这样的结果。这就是 libclang-dev 的安装路径了。哈哈，是不是很详细。修改配置文件中的  libclang 的路径就好了。
 
 
 原文链接：https://blog.csdn.net/typeof_/article/details/22715031""''''''
 https://blog.csdn.net/typeof_/article/details/22715031
