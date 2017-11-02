# [My Way]Linux Command--fuser

## fuser 简介
使用文件或文件结构识别进程。
## fuser 安装
>yum install psmisc
## fuser 描述
fuser 命令列示了本地进程的进程号，那些本地进程使用 File 参数指定的本地或远程文件。对于阻塞特别设备，此命令列示了使用该设备上任何文件的进程。

每个进程号后面都跟随一个字母，该字母指示进程如何使用文件。

    c      current directory.
    e      executable being run.
    f      open file.  f isomitted in default displaymode.
    F      open file for writing. F is omitted in defaultdisplay mode.
    r      root directory.
    m      mmap'ed file or sharedlibrary.

## fuser 使用
* 语法
    >fuser [-fuv] [-a|-s] [-4|-6] [-c|-m|-n space] [ -k [-i] [-M] [-w] [-SIGNAL] ] name ...
* -a 显示所有命令行中指定的文件，默认情况下被访问的文件才会被显示。
    >fuser -a /usr/local
* -c 和-m一样，用于POSIX兼容。
    >fuser -c /data/
* -k 杀掉访问文件的进程。如果没有指定-signal就会发送SIGKILL信号
    >fuser -km /etc/passwd
* -i 杀掉进程之前询问用户，如果没有-k这个选项会被忽略。
    >fuser -k -i -m /etc/passwd
* -m name 指定一个挂载文件系统上的文件或者被挂载的块设备（名称name）。这样所有访问这个文件或者文件系统的进程都会被列出来。如果指定的是一个目录会自动转换成"name/",并使用所有挂载在那个目录下面的文件系统。
    >fuser -m /root
* -n space 指定一个不同的命名空间(space).这里支持不同的空间文件(文件名，此处默认)、tcp(本地tcp端口)、udp(本地udp端口)。对于端口， 可以指定端口号或者名称，如果不会引起歧义那么可以使用简单表示的形式，例如：name/space (即形如:80/tcp之类的表示)。 
    > fuser -v -n udp 323
* -v 详细模式。输出似ps命令的输出，包含PID,USER,COMMAND等许多域,如果是内核访问的那么PID为kernel.
    >fuser -v /root
* -u 在每个PID后面添加进程拥有者的用户名称。
    >fuser -u /root
* -4 使用IPV4套接字,不能和-6一起应用，只在-n的tcp和udp的命名存在时不被忽略。
    >fuser -v -n udp 323 -4
* -6 使用IPV6套接字,不能和-4一起应用，只在-n的tcp和udp的命名存在时不被忽略。  
    >fuser -v -n udp 323 -6
## 其他使用方式
可以通过`man fuser`查看具体使用方式


