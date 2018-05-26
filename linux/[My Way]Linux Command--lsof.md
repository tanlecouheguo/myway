# [My Way]Linux Command--lsof

## lsof 简介
lsof(list open files)是一个列出当前系统打开文件的工具
## lsof 安装
    yum install lsof
## lsof 使用
* 文件和文件目录

        lsof filename      
        lsof folder

* -p  进程Id

        lsof -p 344,223
        
* -i  [i] 根据网络地址匹配
    
        [i] ---    [46][protocol][@hostname|hostaddr][:service|port]

        46 specifies the IP version, IPv4 or IPv6
            that applies to the following address.
            '6' may be be specified only if the UNIX
            dialect supports IPv6.  If neither '4' nor
            '6' is specified, the following address
            applies to all IP versions.
        protocol is a protocol name - TCP, UDP
        hostname is an Internet host name.  Unless a
            specific IP version is specified, open
            network files associated with host names
            of all versions will be selected.
        hostaddr is a numeric Internet IPv4 address in
            dot form; or an IPv6 numeric address in
            colon form, enclosed in brackets, if the
            UNIX dialect supports IPv6.  When an IP
            version is selected, only its numeric
            addresses may be specified.
        service is an /etc/services name - e.g., smtp -
            or a list of them.
        port is a port number, or a list of them.

        lsof -i 4  
        lsof -i 4tcp   
        lsof -i 4tcp@localhost     
        lsof -i 4tcp@127.0.0.1     
        lsof -i 4tcp@localhost:ssh    
        lsof -i 4tcp@localhost:8080    
        lsof -i :500-1000
* -U  获取UNIX套接口地址、

        lsof -i -U

* -u  匹配用户Id或者用户名称

        lsof -u 0,root

* -c 指定命令所打开的文件

        lsof -c docker 

* -t 只显示PID

        lsof -t

## 其他使用方式
可以通过`man lsof`查看具体使用方式


