#!/bin/bash

CONFIG_SYS=/etc/tmux.conf
CONFIG_TAR=`pwd`/tmux.conf

if [ -f $CONFIG_SYS ] || [ -L $CONFIG_SYS ];
then
	echo 'backing up original config' $CONFIG_SYS
	mv $CONFIG_SYS $CONFIG_SYS.$$$$.bckp
fi

echo 'creating new config link' $CONFIG_SYS '->' $CONFIG_TAR 
ln -s $CONFIG_TAR $CONFIG_SYS
