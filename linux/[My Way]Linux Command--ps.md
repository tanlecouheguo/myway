# [My Way]Linux Command--ps

## ps 简介
报告当前进程的快照
## ps 语法
    ps [options]
## ps 使用
    a 列出所有具有终端(tty)的进程，或者在与x选项一起使用时列出所有进程

    x 与a一起使用列车所有进程
    
    -U userlist 根据实际用户ID(RUID)或名称选择。它选择在userlist列表中实际用户名或ID的进程。真正的用户ID是指创建进程的用户

    -u userlist 选择有效的用户ID(EUID)或名称。这将选择在userlist中有效的用户名或ID的进程。有效的用户ID是指该进程使用的文件访问权限的用户

    -G grplist 由真实的组ID(RGID)或名称选择。这将选择在grplist列表中实际组名或ID的进程。真正的组ID指创建进程的用户组

    -g grplist 

    s 显示信号格式
    
    u 面向用户的格式显示

    v 以虚拟内存格式的格式显示

    p pidlist 根据pid列表查询

## 使用案例

    ps aux     
    ps u -u root   
    ps u -g root   
    ps u p 1   


## 其他使用方式
可以通过`man ps`查看具体使用方式


