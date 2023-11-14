#!/bin/bash

git config --global user.name "herotan24"
git config --global user.email "yuhua_tan24@sina.com"

apps=(git tig tmux fish vim tree)

apt install -y ${apps[@]}
