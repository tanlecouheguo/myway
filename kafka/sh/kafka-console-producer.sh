#!/bin/bash
#getopt安装：brew install gnu-getopt
#加入环境变量：echo 'export PATH="/usr/local/opt/gnu-getopt/bin:$PATH"' >> ~/.bash_profile

echo "$@" | xargs kafka-console-producer --broker-list localhost:9093,localhost:9094,localhost:9095,localhost:9096