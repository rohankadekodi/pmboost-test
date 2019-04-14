#!/bin/bash

set -x

src_path=../linux-4.13
kbuild_path=../kbuild
root_path=$(pwd)/..

# Go to kernel build path
cd $kbuild_path

make -f Makefile.setup .config
make -f Makefile.setup
sleep 10
make -j 4 # compile kernel
sleep 10
sudo make modules_install ; sudo make install # install modules

cd $script_path

