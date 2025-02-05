#!/bin/sh
set -x

# 参数
B_USERNAME=XXXX
B_IP=XXXX
FWD0=-R\ YY0:localhost:ZZ0
FWD1=
FWD2=
FWD3=
FWD4=
FWD5=
FWD6=
FWD7=
FWD8=
FWD9=
FWD10=
RETRY_DELAY=5

while [ 1 == 1 ]; do
    date
    ssh -N \
        -o ConnectTimeout=30 -o ServerAliveInterval=30 -o ServerAliveCountMax=1 \
        ${FWD0} \
        ${FWD1} \
        ${FWD2} \
        ${FWD3} \
        ${FWD4} \
        ${FWD5} \
        ${FWD6} \
        ${FWD7} \
        ${FWD8} \
        ${FWD9} \
        ${B_USERNAME}@${B_IP}
    echo "ssh fail or unexpected exited, run again after ${RETRY_DELAY} seconds"
    sleep ${RETRY_DELAY}
done
