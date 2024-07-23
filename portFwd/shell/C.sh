#!/bin/sh
set -x

# 定义一个函数来杀死监听指定端口的所有进程
kill_process_on_port() {
    local port=$1
    if [[ -z "$port" ]]; then
        echo "Usage: kill_process_on_port <port>"
        return 1
    fi

    # 查找监听指定端口的所有进程的PID
    local pids=$(lsof -i :$port | awk 'NR>1 {print $2}' | uniq)

    # 检查是否找到了任何进程
    if [ -z "$pids" ]; then
        echo "No process found on port $port."
        return 0
    fi

    echo "Found processes on port $port with PIDs: $pids"
    # 杀死这些进程
    for pid in $pids; do
        echo "Killing process with PID: $pid"
        kill $pid
    done
}

# 参数
B_USERNAME=XXXX
B_IP=XXXX
FWD0=-L\ XX0:localhost:YY0
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
	kill_process_on_port 10000
	kill_process_on_port 10022
	kill_process_on_port 15900
	kill_process_on_port 20022
	kill_process_on_port 25900
    date
    ssh \
        -o ServerAliveInterval=30 -o ServerAliveCountMax=1 \
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
