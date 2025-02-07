#!/usr/bin/env bash
################################################################################
# 启用 Bash 严格模式：
#   -e: 当任意命令返回非零状态（即出错）时，脚本会立即退出，
#       避免错误被忽略，导致后续命令在错误环境下继续执行。
#   -u: 当引用未定义变量时，脚本会报错并退出，有助于捕捉拼写错误或遗漏定义变量的问题。
#   -o pipefail: 当管道中任一命令失败时，整个管道返回失败状态（而非仅返回最后一个命令的状态）。
################################################################################
set -euo pipefail

# 不同操作系统上，名字相同的软件包
common_apps=(git tig tmux fish vim tree cmake nodejs pyenv make coreutils)

# 不同操作系统上，名字“不”相同的软件包
macos_apps=(python go)
ubuntu_apps=(python3 golang)
centos_apps=(python3 golang)

# 获取操作系统类型
os=$(uname -s)

case "$os" in
    Darwin)
        echo "Detected macOS."
        # 检查 Homebrew 是否已安装
        if ! command -v brew &> /dev/null; then
            echo "Homebrew is not installed. Please install Homebrew from https://brew.sh/."
            exit 1
        fi
        # 直接使用 Homebrew 批量安装常用和 macOS 特有的软件包
        echo "Installing apps via Homebrew..."
        brew install "${common_apps[@]}" "${macos_apps[@]}"
        ;;

    Linux)
        # 判断 /etc/os-release 文件是否存在以确定发行版信息
        if [ -f /etc/os-release ]; then
            . /etc/os-release
            distro=$ID
        else
            echo "/etc/os-release not found, cannot determine Linux distribution."
            exit 1
        fi

        case "$distro" in
            ubuntu)
                echo "Detected Ubuntu."
                sudo apt update
                # 直接使用 apt 批量安装常用和 Ubuntu 特有的软件包
                echo "Installing apps via apt..."
                sudo apt install -y "${common_apps[@]}" "${ubuntu_apps[@]}"
                ;;

            centos)
                echo "Detected CentOS."
                sudo yum check-update || true
                # 直接使用 yum 批量安装常用和 CentOS 特有的软件包
                echo "Installing apps via yum..."
                sudo yum install -y "${common_apps[@]}" "${centos_apps[@]}"
                ;;

            *)
                echo "Unsupported Linux distribution: $distro"
                exit 1
                ;;
        esac
        ;;

    *)
        echo "Unsupported operating system: $os"
        exit 1
        ;;
esac

echo "Installation completed."
