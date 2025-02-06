#!/usr/bin/env bash
################################################################################
# 启用 Bash 严格模式：
#   -e: 当任意命令返回非零状态（即出错）时，脚本会立即退出，
#       避免错误被忽略，导致后续命令在错误环境下继续执行。
#   -u: 当引用未定义变量时，脚本会报错并退出，有助于捕捉拼写错误或遗漏定义变量的问题。
#   -o pipefail: 当管道中任一命令失败时，整个管道返回失败状态（而非仅返回最后一个命令的状态）。
################################################################################
set -euo pipefail

git config --global user.name "herotan24"
git config --global user.email "yuhua_tan24@sina.com"

apps=(git tig tmux fish vim tree)

apt install -y ${apps[@]}
