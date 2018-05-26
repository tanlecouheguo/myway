# [My Way]Linux Package Manager--yum

## yum 简介
Yum（全称为 Yellow dog Updater, Modified）是一个在Fedora和RedHat以及CentOS中的Shell前端软件包管理器。基于RPM包管理，能够从指定的服务器自动下载RPM包并且安装，可以自动处理依赖性关系，并且一次安装所有依赖的软件包，无须繁琐地一次次下载、安装。

## yum 安装
Fedora和RedHat以及CentOS系统默认自带

## yum 使用
* install 安装软件包

        yum install 包名

* -y 自动应答yes

        yum install -y 包名

* reinstall 重新安装包

        yum reinstall 包名

* update 更新包

        yum update 包名

* remove 删除软件包

        yum remove 包名

* provides 查找程序由哪个包提供

        yum provides fuser

* list installed 已安装的包

        yum list installed

* search [关键字] 搜索包

        yum search netstat
        


