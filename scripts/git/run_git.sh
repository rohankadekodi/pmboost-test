#!/bin/bash

current_dir=$(pwd)
setup_dir=`readlink -f ..`
pmem_dir=/mnt/pmem_emul

run_git()
{
    fs=$1
    for run in 1 2 3
    do
        sudo rm -rf $pmem_dir/*
        sudo ./run_fs.sh $fs $run
        sleep 5
    done
}

run_git_boost()
{
    fs=$1
    for run in 1 2 3 4 5
    do
        sudo rm -rf $pmem_dir/*
        sudo ./run_boost.sh $fs $run
        sleep 5
    done
}

:'
cd $setup_dir
sudo ./nova_config.sh
cd $current_dir
sudo $setup_dir/dax_config.sh
run_git dax

cd $setup_dir
sudo ./nova_relaxed_config.sh
cd $current_dir
run_git relaxed_nova

cd $setup_dir
sudo ./nova_config.sh
cd $current_dir
run_git nova

cd $setup_dir
sudo $setup_dir/pmfs_config.sh
cd $current_dir
run_git pmfs
'

sudo $setup_dir/dax_config.sh
run_git_boost boost

sudo $setup_dir/dax_config.sh
run_git_boost sync_boost

sudo $setup_dir/dax_config.sh
run_git_boost posix_boost
