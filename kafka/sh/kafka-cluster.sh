#!/bin/sh
#getopt安装：brew install gnu-getopt
#加入环境变量：echo 'export PATH="/usr/local/opt/gnu-getopt/bin:$PATH"' >> ~/.bash_profile
_command=$@
# read the options
TEMP=$(getopt -o p:b: --long port:,broker-id:,bootstrap-server::,topic:,action:: -- "$@")
eval set -- "$TEMP"
# extract options and their arguments into variables.
while true; do
    case "$1" in
    -p | --port)
        port=$2
        shift 2
        ;;
    -b | --broker-id)
        broker_id=$2
        shift 2
        ;;
    --topic)
        topic=$2
        shift 2
        ;;
    --)
        shift
        break
        ;;
    *)
        echo "Internal error!"
        exit 1
        ;;
    esac
done

#获取当前脚本文件的绝对路径
SHELL_FOLDER=$(
    cd "$(dirname "$0")"
    pwd
)
CONFIG_DIR=$SHELL_FOLDER

cfile() {
    if [ ! $port ]; then
        exit 1
    fi
    if [ ! $broker_id ]; then
        exit 1
    fi

    cat $CONFIG_DIR/server.properties | sed -e "s/_port/$port/g" -e "s/_broker_id/$broker_id/g" >$CONFIG_DIR/server-$broker_id.properties
}

start(){
    if [ ! $broker_id ]; then
        exit 1
    fi
    nohup kafka-server-start $CONFIG_DIR/server-$broker_id.properties >/dev/null 2>&1 &
}

stop(){
    if [ ! $broker_id ]; then
        exit 1
    fi
    nohup kafka-server-stop $CONFIG_DIR/server-$broker_id.properties >/dev/null 2>&1 &
}

$_command
