# Redis Cluster

## 下载安装Redis

    $ wget http://download.redis.io/releases/redis-4.0.9.tar.gz
    $ tar xzf redis-4.0.9.tar.gz
    $ cd redis-4.0.9
    $ make

## 添加环境变量

    #修改profile文件
    PATH=/path/redis-4.0.9/src:$PATH
    export PATH

## 运行单个Redis服务
    
    redis-server

## 连接Redis

    redis-cli
    
## 创建Redis Cluster

### 创建每个节点的配置文件node.conf

    #7000.conf
    port 7000 #启动的端口，每个节点需要修改
    cluster-enabled yes
    cluster-config-file nodes.conf #集群配置文件，每个节点需要修改
    cluster-node-timeout 5000
    appendonly yes
    # The working directory.
    #
    # The DB will be written inside this directory, with the filename specified
    # above using the 'dbfilename' configuration directive.
    #
    # The Append Only File will also be created inside this directory.
    #
    # Note that you must specify a directory here, not a file name.
    dir ./
    
### 将集群配置文件放入不同目录

    mkdir cluster-test
    cd cluster-test
    mkdir 7000 7001 7002 7003 7004 7005

### 启动集群节点

    cd 7000
    redis-server 7000.conf
    #启动其他节点
    
### 将节点加入到集群

#### 使用redis-trib.rb
##### 安装ruby环境(ruby环境不可用的情况下)

    yum install ruby
    yum install rubygems
    
##### 安装ruby的redis插件

    gem install redis

##### 将刚刚启动的redis server加入集群

    redis-trib.rb  create --replicas 1 127.0.0.1:7000 127.0.0.1:7001 127.0.0.1:7002 127.0.0.1:7003 127.0.0.1:7004 127.0.0.1:7005

