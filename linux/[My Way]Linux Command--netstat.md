# [My Way]Linux Command--netstat

## netstat 简介
netstat可以显示网络连接，路由表，接口信息，多播信息等
## netstat 安装
>yum install net-tools
## netstat 语法
    netstat   [address_family_options]  [--tcp|-t]  [--udp|-u]  [--udplite|-U]  [--sctp|-S]  [--raw|-w]  [--listening|-l]  [--all|-a]  [--numeric|-n]  [--numeric-hosts]
    [--numeric-ports] [--numeric-users] [--symbolic|-N] [--extend|-e[--extend-e]] [--timers|-o] [--program|-p] [--verbose|-v] [--continuous|-c] [--wide-W] [delay]

    netstat {--route|-r} [address_family_options] [--extend|-e[--extend|-e]][--verbose|-v] [--numeric|-n] [--numeric-hosts] [--numeric-ports][--numeric-users] [--con‐
    tinuous|-c] [delay]

    netstat {--interfaces|-I|-i} [--all|-a] [--extend|-e] [--verbose|-v][--program|-p] [--numeric|-n] [--numeric-hosts] [--numeric-ports][--numeric-users] [--continu‐
    ous|-c] [delay]

    netstat {--groups|-g} [--numeric|-n] [--numeric-hosts] [--numeric-ports][--numeric-users] [--continuous|-c] [delay]

    netstat {--masquerade|-M} [--extend|-e] [--numeric|-n] [--numeric-hosts][--numeric-ports] [--numeric-users] [--continuous|-c] [delay]

    netstat {--statistics|-s} [--tcp|-t] [--udp|-u] [--udplite|-U] [--sctp|-S][--raw|-w] [delay]

    netstat {--version|-V}

    netstat {--help|-h}

    address_family_options:

    [-4|--inet] [-6|--inet6] [--protocol={inet,inet6,unix,ipx,ax25,netrom,ddp,... } ] [--unix|-x]  [--inet|--ip|--tcpip]  [--ax25]  [--x25]  [--rose] [--ash]  [--ipx]
    [--netrom] [--ddp|--appletalk] [--econet|--ec]

## netstat 使用
* -a 显示所有socket
    >netstat -a
* -v 显示详细的信息
    >netstat -av
* -r 显示路由表信息
    >netstat -r
* -g 显示IPV4和IPV6的多播组信息
    >netstat -g
* -i -I=iface 显示所有的网络接口信息，或现在iface指定的接口信息
    >netstat -i     
    >netstat -I=docker
* -s 显示没种协议的统计信息
    >netstat -s
* -n 显示数字地址，而不是试图确定符号主机、端口或用户名
    >netstat -n    
* -p 显示每个套接字所属的程序的PID和名称
    >netstat -p  
* -o, --timers 包括与网络计时器相关的信息  
    >netstat -o
* -c 每隔1秒就重新显示一遍，直到用户中断它
    >netstat -apnc
* -l 只显示正在监听的server socket
    >netstat -l
## 其他使用方式
可以通过`man netstat`查看具体使用方式


