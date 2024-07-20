#!/bin/bash
set -ex

INSTALL_PATH=/etc/systemd/system/ssh-tunnel.service
SOURCE_PATH=`pwd`/ssh-tunnel.service

if [ -f $INSTALL_PATH ] || [ -L $INSTALL_PATH ] || [ -d $INSTALL_PATH ];
then
	echo 'backing up original config' $INSTALL_PATH
	mv $INSTALL_PATH $INSTALL_PATH.$$$$.bckp
fi

echo 'creating new service link' $INSTALL_PATH '->' $SOURCE_PATH 
ln -s $SOURCE_PATH $INSTALL_PATH

systemctl daemon-reload  # 重新加载systemd，识别新的服务文件
systemctl enable ssh-tunnel.service  # 启用服务，确保开机自启
systemctl start ssh-tunnel.service  # 启动服务
systemctl status ssh-tunnel.service
