#!/bin/sh

while true
do
    git submodule update --init --recursive
    if [ $? != 0 ]
    then
        echo "fail"
    else
        echo "ok"
        exit 0
    fi
    sleep 1
done
