#!/bin/sh

nodePorts=`seq 7000 7005`
for nodePort in $nodePorts
do
    redis-cli -c -p ${nodePort} shutdown
done