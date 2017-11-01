#!/bin/bash

FISHCONFIG_SYS=/etc/fish/config.fish
FISHCONFIG_TAR=`pwd`/config.fish

if [ -f $FISHCONFIG_SYS ] || [ -L $FISHCONFIG_SYS ];
then
	echo 'backing up original config' $FISHCONFIG_SYS
	mv $FISHCONFIG_SYS $FISHCONFIG_SYS.$$$$.bckp
fi

echo 'creating new config link' $FISHCONFIG_SYS '->' $FISHCONFIG_TAR 
ln -s $FISHCONFIG_TAR $FISHCONFIG_SYS
