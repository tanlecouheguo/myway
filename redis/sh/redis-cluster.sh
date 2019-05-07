#!/bin/sh

#获取当前脚本文件的绝对路径
SHELL_FOLDER=$(
    cd "$(dirname "$0")"
    pwd
)
#dir=/Users/paul/Software/redis-cluster
dir=$SHELL_FOLDER
cdir() {
    for nodePort in $*; do
        if [ ! -d ${dir}/${nodePort} ]; then
            echo "${dir}/${nodePort}"
            mkdir "${dir}/${nodePort}"
        fi
    done
}

CONFIG_DIR=$SHELL_FOLDER

cfile() {
    oport=${2:-_port}
    nport=${2:-$1}
    if [ ! $nport ]; then
        exit 1
    fi
    cat $CONFIG_DIR/redis.conf | sed -e "s/$oport/$nport/g" >${dir}/$nport/redis.conf
}

start() {
    ROOT_DIR=/Users/paul/Software/redis-cluster
    for nodePort in $*; do
        CONFIG_PATH=${ROOT_DIR}/${nodePort}/redis.conf
        if [ -f ${CONFIG_PATH} ]; then
            #echo $CONFIG_PATH
            redis-server ${CONFIG_PATH}
        fi
    done
}

stop() {
    ps aux | grep redis | awk '{print $2}' | xargs kill
}

"$@"
