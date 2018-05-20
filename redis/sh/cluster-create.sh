#!/bin/sh

dir='./'
nodePorts=`seq 7000 7005`

createConf(){
    mkdir ${2}
    #将/替换成\/
    #命令行只要echo $1|sed 's/\//\\\//'
    #shell脚本里面echo $1|sed 's/\//\\\\\//'
    tempDir=`echo $1$2/|sed 's/\//\\\\\//g'`
    echo $tempDir
    nodeConfPath=$1$2/$2.conf
    sed -e "s/dirPath/$tempDir/" -e "s/7000/$2/" node.conf > $nodeConfPath
    redis-server $nodeConfPath
}

for nodePort in ${nodePorts}
do
    if [ -d ${nodePort} ]
    then
        rm -rf ${nodePort}
        createConf ${dir} ${nodePort}
    else
        mkdir ${nodePort}
        createConf ${dir} ${nodePort}
    fi

done

