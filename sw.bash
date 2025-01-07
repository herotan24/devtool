#!/bin/bash
set -ex


apps=(git tig tmux fish vim tree make cmake coreutils python3-pip libevent-dev bison libncurses-dev make build-essential libssl-dev zlib1g-dev libbz2-dev \
	libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev \
	xz-utils tk-dev libffi-dev liblzma-dev python-openssl git)

os=$(uname -s)
if [ "$os" = "Darwin" ]; then
    brew install ${apps[@]}
elif [ "$os" = "Linux" ]; then
    # 判断是 Ubuntu 还是 CentOS
    if grep -q "Ubuntu" /etc/os-release; then
        apt install -y ${apps[@]}
    elif grep -q "Debian" /etc/os-release; then
        apt install -y ${apps[@]}
    elif grep -q "CentOS" /etc/os-release; then
        yum install -y ${apps[@]}
    else
        echo "Unknown Linux distribution."
        exit -1
    fi
else
    echo "Unknown operating system."
    exit -1
fi

exit 0
