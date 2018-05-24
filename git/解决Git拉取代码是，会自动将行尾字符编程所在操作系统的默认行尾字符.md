# 解决Git拉取代码是，会自动将行尾字符编程所在操作系统的默认行尾字符
如果是`linux`和`windows`混合开发，很容易会遇到行尾换行符的问题，windows下默认是`\r\n`，linux下是`\n`。如果没做处理，git提交时很有可能产生问题，解决办法为设置`git config`的 `core.autocrlf`

## 关闭自动改变默认行尾字符功能的两种方式

1. 使用仓库配置文件
    
        git config core.autocrlf false
        git config -- local core.autocrlf false

    将会在仓库的`.git/config`文件中增加下面的配置

        [core]
            repositoryformatversion = 0
            filemode = false
            bare = false
            logallrefupdates = true
            symlinks = false
            ignorecase = true
            autocrlf = false

2. 使用全局配置文件

        git config --global core.autocrlf false

    将会在`~/.gitconfig`文件中增加下面的配置

        [core]
	        autocrlf = false
