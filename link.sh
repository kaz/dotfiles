#!/bin/sh -xe

CUR=$(cd $(dirname $0) && pwd)

ln -sf $CUR/.bash_profile ~
ln -sf $CUR/.devcontainer ~
ln -sf $CUR/.tmux.conf ~
ln -sf $CUR/.gitconfig ~
ln -sf $CUR/.database ~
