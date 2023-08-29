#!/bin/bash

INSTALL_DIR_ROOT=${HOME}/.config
mkdir -p ${INSTALL_DIR_ROOT}
INSTALL_DIR=${INSTALL_DIR_ROOT}/tmux
SOURCE_DIR=`pwd`

if [ -f $INSTALL_DIR ] || [ -L $INSTALL_DIR ];
then
	echo 'backing up original config' $INSTALL_DIR
	mv $INSTALL_DIR $INSTALL_DIR.$$$$.bckp
fi

echo 'creating new config link' $INSTALL_DIR '->' $SOURCE_DIR 
ln -s $SOURCE_DIR $INSTALL_DIR
