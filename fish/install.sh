#!/bin/bash

mkdir -p ${HOME}/.config
TARGET_DIR=~/.config/fish
SOURCE_DIR=$(cd `dirname $0`; pwd)

if [ -d $TARGET_DIR ] || [ -L $TARGET_DIR ];
then
	echo 'backing up original config' $TARGET_DIR
	mv $TARGET_DIR $TARGET_DIR.$$$$.bckp
fi

echo 'creating new config link' $TARGET_DIR '->' $SOURCE_DIR 
ln -s $SOURCE_DIR $TARGET_DIR
