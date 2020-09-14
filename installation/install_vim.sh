#!/bin/bash

# Clone the source code
tmp_dir=./install_tmp
mkdir $tmp_dir; cd $tmp_dir
git clone https://github.com/vim/vim.git

# Setting the default installation PATH (PREFIX)
read -p "Prefix path for installing vim [Default: /usr/local/]" PREFIX
PREFIX=${PREFIX:-"/usr/local/"}

# Starting compilation
cd vim/src
./configure --prefix=$PREFIX \
    --mandir=$(which man) \
    --with-features=huge \
    --enable-multibyte \
    --with-tlib=ncurses \
    --enable-cscope \
    --enable-terminal \
    --with-compiledby=$USER \
    --enable-python3interp=yes \
    --with-python3-config-dir=$(python3-config --configdir) \
    --enable-gui=no \
    --without-x

sudo make -j8
sudo make install -j8

# Removing the source code
cd ../../..
rm -rf $tmp_dir
