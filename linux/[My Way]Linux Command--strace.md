# [My Way]Linux Command--strace

## strace 简介
strace是一种有用的诊断、指导和调试工具。系统管理员，诊断专家和解决问题的人将会发现它对于解决问题是无价的。由于不需要重新编译源代码以跟踪它们，所以无法很容易地找到源文件的问题。学生，黑客和过分好奇的人会发现，通过追踪甚至是普通的程序，可以了解到一个系统及其系统调用。程序员会发现由于系统调用和信号是在用户/内核接口中发生的事件，因此对这个边界进行仔细的检查对于bug隔离和清醒非常有用。
## strace 安装
>yum install strace
## strace 语法
    strace [-CdffhikqrtttTvVxxy] [-In] [-bexecve] [-eexpr]...  [-acolumn] [-ofile] [-sstrsize] [-Ppath]... -ppid... / [-D] [-Evar[=val]]... [-uusername] command [args]

    strace -c[df] [-In] [-bexecve][-eexpr]...  [-Ooverhead] [-Ssortby -ppid... / [-D] [-Evar[=val]]...[-uusername] command [args]

## strace 使用
    -c 计算每个系统调用的时间、调用和错误，并报告程序退出的摘要。在Linux上，它试图显示系统时间(在内核中运行的CPU时间)独立于挂钟时间。如果-c与-f或-f(以下)一起使用，则只保留所有跟踪过程的总总数

    -C 与-c一样，但同时在进程运行时打印常规输出

    -d 输出strace关于标准错误的调试信息

    -p pid 跟踪指定的进程pid

    -i 在系统调用时打印指令指针

    -r 在每个系统调用的条目上打印一个相对时间戳。这记录了连续系统调用开始时的时间差异

    -t 将跟踪的每一行加上当前的时间

    -tt 如果给定两次，打印的时间将包括微秒

    -ttt 打印的时间将包括微秒，而主要的部分将被打印成自计算机历史以来的秒数

    -T 显示系统调用所花费的时间。这将记录每个系统调用的开始和结束之间的时间差异

    -e expr 指定一个表达式,用来控制如何跟踪.格式：[qualifier=][!]value1[,value2]... qualifier只能是 trace,abbrev,verbose,raw,signal,read,write其中之一.value是用来限定的符号或数字.默认的 qualifier是 trace.感叹号是否定符号.例如:-eopen等价于 -e trace=open,表示只跟踪open调用.而-etrace!=open 表示跟踪除了open以外的其他调用.有两个特殊的符号 all 和 none. 注意有些shell使用!来执行历史记录里的命令,所以要使用\\. 

    -e trace=set 只跟踪指定的系统 调用.例如:-e trace=open,close,rean,write表示只跟踪这四个系统调用.默认的为set=all. 
    
    -e trace=file 只跟踪有关文件操作的系统调用. 
    
    -e trace=process 只跟踪有关进程控制的系统调用. 
    
    -e trace=network 跟踪与网络有关的所有系统调用.
    
    -e strace=signal 跟踪所有与系统信号有关的 系统调用 
     
    -e trace=ipc 跟踪所有与进程通讯有关的系统调用 
     
    -e abbrev=set 设定strace输出的系统调用的结果集.-v 等与 abbrev=none.默认为abbrev=all.
     
    -e raw=set 将指定的系统调用的参数以十六进制显示.
      
    -e signal=set 指定跟踪的系统信号.默认为all.如 signal=!SIGIO(或者signal=!io),表示不跟踪SIGIO信号. 
       
    -e read=set 输出从指定文件中读出 的数据.例如: -e read=3,5 
       
    -e write=set 输出写入到指定文件中的数据.

    -o filename 将strace的输出写入文件filename

## 其他使用方式
可以通过`man strace`查看具体使用方式


